from flask import Flask, render_template, request, redirect, session
from datetime import timedelta, datetime

import pyodbc

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


app = Flask(__name__)

# This is necessary for the session to work
app.secret_key = 'shems_datab_proj2132'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=7)  

@app.route('/')
def index():
    # Redirect to login page as the default page
    return redirect('/login')

@app.route('/login', methods=['GET'])
def login():
    return render_template('login.html')

@app.route('/homepage')
def homepage():
    if 'user_name' in session:
        # Assuming we have a function get_pid_by_name that gets the pid based on the user's name
        pid = get_pid_by_name(session['user_name'])
        
        # Assuming we have a function get_service_locations_by_pid that gets service locations for a pid
        service_locations = get_service_locations_by_pid(pid)
        
        return render_template('homepage.html', name=session['user_name'], service_locations=service_locations)
    else:
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

        # You'll need the user's ID for the cust_id, assuming you have a way to retrieve it
        cust_id = get_pid_by_name(session['user_name'])

        # Now insert the new service location into the database
        conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=DESKTOP-KTBJ3S3\SQLEXPRESS;'
        'DATABASE=SHEMS;'
        'Trusted_Connection=yes;'
    )
        cursor = conn.cursor()
        today = str(datetime.now().hour) + str(datetime.now().minute) + str(datetime.now().second)
        cursor.execute("INSERT INTO ServiceLocation (sl_id, cust_id, sl_unit_no, sl_addr, sl_city, sl_state, sl_zip, sl_boughtat, sl_squarefootage, sl_bedrooms, sl_occupants) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
               (today, cust_id, unit_number, address, city, state, zipcode, bought_at, square_footage, number_of_bedrooms, number_of_occupants))
        conn.commit()
        cursor.close()
        conn.close()
        
        # Redirect to the homepage after insertion
        return redirect('/homepage')
    else:
        return redirect('/login')


@app.route('/logout')
def logout():
    # Remove user_name from session
    session.pop('user_name', None)
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True)
