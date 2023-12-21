from flask import Flask, render_template, request, redirect, session, url_for
from datetime import timedelta, datetime

import pyodbc

def fetch_energy_data_by_zip(customer_id):
    # Database connection credentials
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
    cursor = conn.cursor()
    
    query = """
    SELECT sl.sl_zip, SUM(el.el_val) AS TotalEnergyUsed
    FROM ServiceLocation sl
    JOIN Device d ON sl.sl_id = d.sl_id
    JOIN EnergyLog el ON d.dev_id = el.dev_id
    WHERE sl.cust_id = ?
    GROUP BY sl.sl_zip
    """
    
    
    cursor.execute(query, customer_id)
    
    
    energy_data = cursor.fetchall()

    cursor.close()
    conn.close()
    
    energy_data_list = [{'ZIPCode': row.sl_zip, 'TotalEnergyUsed': row.TotalEnergyUsed} for row in energy_data]
    
    return energy_data_list


def get_pid_by_name(user_name):
    # Assuming 'user_name' maps to a 'name' column in the 'Customer' table
    # and 'pid' is a column in the same table
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
    cursor = conn.cursor()
    cursor.execute("SELECT cust_id FROM Customer WHERE cust_fname = ?", user_name)
    row = cursor.fetchone()
    cursor.close()
    conn.close()
    return row.cust_id if row else None

def get_service_locations_by_pid(pid):
    # Assuming 'ServiceLocation' table has 'pid' as a foreign key to 'Customer'
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM ServiceLocation WHERE cust_id = ?", pid)
    locations = cursor.fetchall()
    cursor.close()
    conn.close()
    return locations

def fetch_weekly_energy_data(user_id):
    # Connect to your database
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                          'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
                          'DATABASE=SHEMS;'
                          'Trusted_Connection=yes;')
    cursor = conn.cursor()

    # Fetch the weekly energy consumption for the user's service locations
    query = """
    SELECT 
        sl.sl_id AS ServiceLocationID, 
        DATEPART(week, el.el_time) AS WeekOfYear,
        DATEPART(year, el.el_time) AS Year,
        SUM(el.el_val) AS TotalEnergyUsed
    FROM 
        EnergyLog el
    JOIN 
        Device d ON el.dev_id = d.dev_id
    JOIN 
        ServiceLocation sl ON d.sl_id = sl.sl_id
    WHERE 
        sl.cust_id = ? AND 
        el.el_time BETWEEN '2022-07-01' AND '2022-12-31'
    GROUP BY 
        sl.sl_id, 
        DATEPART(week, el.el_time),
        DATEPART(year, el.el_time)
    ORDER BY 
        Year, WeekOfYear
    """
    
    cursor.execute(query, user_id)
    results = cursor.fetchall()
    
    # Close the cursor and the connection
    cursor.close()
    conn.close()

    # Organize the results by service location
    weekly_data = {}
    for row in results:
        location_id = row.ServiceLocationID
        if location_id not in weekly_data:
            weekly_data[location_id] = []
        weekly_data[location_id].append({
            'week': f"{row.Year}-W{row.WeekOfYear}",
            'energy': row.TotalEnergyUsed
        })
    return weekly_data

def fetch_energy_usage_per_service_location(customer_id):
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
    cursor = conn.cursor()
    
    query = """
    SELECT ServiceLocationID, SUM(TotalEnergyUsed) AS TotalEnergy
    FROM VwEnergyUsagePerUser
    WHERE CustomerID = ?
    GROUP BY ServiceLocationID
    ORDER BY ServiceLocationID
    """
    

    cursor.execute(query, customer_id)
    

    energy_data = cursor.fetchall()
    cursor.close()
    conn.close()
    
    
    energy_data_sl_list = [{'ServiceLocationID': row.ServiceLocationID, 'TotalEnergy': row.TotalEnergy} for row in energy_data]
    
    return energy_data_sl_list

def fetch_energy_data_by_device_type(customer_id):
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
    cursor = conn.cursor()

    query = """
    SELECT DeviceType, SUM(TotalEnergyUsed) as TotalEnergy
    FROM VwCustomerEnergyUsageByDeviceType
    WHERE CustomerID = ?
    GROUP BY DeviceType
    """
    
    cursor.execute(query, customer_id)
    
    # Fetch all rows from the cursor
    energy_data = cursor.fetchall()
    
    # Close the cursor and the connection
    cursor.close()
    conn.close()
    
    # Transform the raw data into a list of dictionaries
    energy_data_list = [
        {'DeviceType': row.DeviceType, 'TotalEnergyUsed': row.TotalEnergy}
        for row in energy_data
    ]

    return energy_data_list

def get_service_location_by_id(id):
    # Assuming 'ServiceLocation' table has 'pid' as a foreign key to 'Customer'
    try:
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
            'DATABASE=SHEMS;'
            'Trusted_Connection=yes;'
        )
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM ServiceLocation WHERE sl_id = ?", id)
        locations = cursor.fetchone()
        cursor.execute("SELECT d.dev_id, dm.m_type, dm.m_name, SUM(e.el_price) AS tot_consume FROM Device d JOIN DeviceModel dm ON dm.mid = d.mid JOIN EnergyLog e ON d.dev_id = e.dev_id WHERE sl_id = ? GROUP BY d.dev_id, dm.m_type, dm.m_name", id)
        devices = cursor.fetchall()
        cursor.execute("SELECT a.act_id, d.dev_id, dm.m_name, a.act_time, a.act_label, a.act_val FROM ActivityLog a JOIN Device d ON d.dev_id = a.dev_id JOIN DeviceModel dm ON d.mid = dm.mid WHERE d.dev_id IN (SELECT dev_id from Device WHERE sl_id = ?) ORDER BY act_time", id)
        activities = cursor.fetchall()
    except Exception as e:
        conn.rollback()
        print(f"An error occurred: {e}")
        return "An error occurred", 500  
    finally:
        cursor.close()
        conn.close()
    return locations, devices, activities


app = Flask(__name__)

# This is necessary for the session to work
app.secret_key = 'shems_datab_proj2132'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(minutes=5)

@app.route('/')
def index():
    # Redirect to login page as the default page
    return redirect('/login')

@app.route('/login', methods=['GET'])
def login():
    return render_template('login.html')

@app.route('/start_session', methods=['POST'])
def start_session():
    user_name = request.form['user_name']
    # In a real-world scenario, you would have additional checks here to ensure that
    # the user_name is valid and that the user is actually authenticated.
    session['user_name'] = user_name
    session['logged_in'] = True
    return redirect(url_for('homepage'))

@app.route('/homepage')
def homepage():
    print(session)
    if 'logged_in' in session and session['logged_in']:
        # Retrieve user details using session['user_name']
        pid = get_pid_by_name(session['user_name'])
        service_locations = get_service_locations_by_pid(pid)
        device_energy_data = fetch_energy_data_by_device_type(pid)
        energy_zip_data = fetch_energy_data_by_zip(pid)
        energy_service_location_data = fetch_energy_usage_per_service_location(pid)
        weekly_data_json = fetch_weekly_energy_data(pid)
        return render_template('homepage.html', user_name=session['user_name'], 
                               service_locations=service_locations, 
                               device_energy_data=device_energy_data, 
                               energy_zip_data=energy_zip_data, 
                               energy_service_location_data=energy_service_location_data,
                               weekly_data_json=weekly_data_json)
    else:
        # If not logged in, redirect to the login page
        return redirect('/login')


@app.route('/add-service-location')
def add_service_location():
    # Make sure the user is logged in
    if 'user_name' in session:
        return render_template('add_service_location.html')
    else:
        return redirect('/login')

@app.route('/submit-service-location', methods=['POST'])
def submit_service_location():
    if 'user_name' in session:
        unit_number = request.form['unit_number']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zipcode = request.form['zipcode']
        bought_at = request.form['bought_at']
        square_footage = request.form['square_footage']
        number_of_bedrooms = request.form['number_of_bedrooms']
        number_of_occupants = request.form['number_of_occupants']

        device_types = request.form.getlist('device_type')
        model_names = request.form.getlist('model_name')
    
        # You'll need the user's ID for the cust_id, assuming you have a way to retrieve it
        cust_id = get_pid_by_name(session['user_name'])

        today = str(datetime.now().hour) + str(datetime.now().minute) + str(datetime.now().second)


        # Now insert the new service location into the database
        try:
            conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
            'DATABASE=SHEMS;'
            'Trusted_Connection=yes;'
        )
            cursor = conn.cursor()
            i = 0
                
            cursor.execute("INSERT INTO ServiceLocation (sl_id, cust_id, sl_unit_no, sl_addr, sl_city, sl_state, sl_zip, sl_boughtat, sl_squarefootage, sl_bedrooms, sl_occupants) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
            (today, cust_id, unit_number, address, city, state, zipcode, bought_at, square_footage, number_of_bedrooms, number_of_occupants))
            
            for device_type, model_name in zip(device_types, model_names):
                dev_id = str(today[::-1] + str(i))
                cursor.execute("SELECT mid FROM DeviceModel WHERE m_type = ? AND m_name = ?", device_type, model_name)
                mid = cursor.fetchone()
                cursor.execute("INSERT INTO Device (dev_id, sl_id, mid) VALUES (?, ?, ?)",
                (dev_id, today, mid.mid))
                i+=1
                conn.commit()
            
            conn.commit() 
        except Exception as e:
            conn.rollback()
            print(f"An error occurred: {e}")
            return "An error occurred", 500  
        finally:
            cursor.close()
            conn.close()

        return redirect('/homepage')
    else:
        return redirect('/login')


@app.route('/service-location/<int:sl_id>')
def service_location_details(sl_id):
    try:
        service_location, devices, activities = get_service_location_by_id(sl_id)
    
        if service_location:
            return render_template('service_location_details.html', location=service_location, devices=devices, activities = activities)
    except Exception as e:
        print(f"An error occurred: {e}")
        return "Service Location not found", 404

@app.route('/logout')
def logout():
    session.pop('user_name', None)
    return redirect('/login')

@app.route('/delete-device/<int:device_id>', methods=['POST'])
def delete_device(device_id):
    if 'logged_in' in session and session['logged_in']:
        try:
            conn = pyodbc.connect(
                'DRIVER={ODBC Driver 17 for SQL Server};'
                'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
                'DATABASE=SHEMS;'
                'Trusted_Connection=yes;'
            )
            cursor = conn.cursor()
            cursor.execute("DELETE FROM ActivityLog WHERE dev_id = ?", device_id)
            cursor.execute("DELETE FROM EnergyLog WHERE dev_id = ?", device_id)
            cursor.execute("DELETE FROM Device WHERE dev_id = ?", device_id)
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"An error occurred: {e}")
            return "An error occurred", 500  
        finally:
            cursor.close()
            conn.close()
            return redirect('/homepage')  # Redirect to a confirmation page or back to the details page
    else:
        return redirect('/login')

@app.route('/delete-service-location/<int:sl_id>', methods=['POST'])
def delete_service_location(sl_id):
    if 'logged_in' in session and session['logged_in']:
        try:
            conn = pyodbc.connect(
                'DRIVER={ODBC Driver 17 for SQL Server};'
                'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
                'DATABASE=SHEMS;'
                'Trusted_Connection=yes;'
            )
            cursor = conn.cursor()
            cursor.execute("DELETE FROM Device WHERE sl_id = ?", sl_id)
            cursor.execute("DELETE FROM ServiceLocation WHERE sl_id = ?", sl_id)
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"An error occurred: {e}")
            return "An error occurred", 500  
        finally:
            cursor.close()
            conn.close()
            return redirect('/homepage')  
    else:
        return redirect('/login')


if __name__ == '__main__':
    app.run(debug=True)
