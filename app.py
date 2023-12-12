from flask import Flask, render_template, request, redirect, session
from datetime import timedelta

app = Flask(__name__)

# This is necessary for the session to work
app.secret_key = 'shems_datab_proj2132'
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=7)  

@app.route('/')
def index():
    # Redirect to login page as the default page
    return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        users = {
            'alicej@email.com': {'password': 'alicej', 'name': 'Alice'},
            'janesmith@email.com': {'password': 'janes', 'name': 'Jane'},
            'johndoe@email.com': {'password': 'johnd', 'name': 'John'}
        }
        user = users.get(email, None)
        if user and user['password'] == password:
            session.permanent = True
            session['user_name'] = user['name']
            print("Login successful, redirecting to homepage")  # Debug print
            return redirect('/homepage')
        else:
            return render_template('login.html', error='Invalid credentials. Please try again.')
    return render_template('login.html')

@app.route('/homepage')
def homepage():
    print(session)
    # Check if the user is in session
    if 'user_name' in session:
        return render_template('homepage.html', name=session['user_name'])
    else:
        # If there is no user in session, redirect to login page
        return redirect('/login')

@app.route('/logout')
def logout():
    # Remove user_name from session
    session.pop('user_name', None)
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True)
