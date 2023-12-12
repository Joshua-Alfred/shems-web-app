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

@app.route('/login', methods=['GET'])
def login():
    return render_template('login.html')

@app.route('/homepage')
def homepage():
     return render_template('homepage.html')


@app.route('/logout')
def logout():
    # Remove user_name from session
    session.pop('user_name', None)
    return redirect('/login')

if __name__ == '__main__':
    app.run(debug=True)
