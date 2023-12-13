// static/login.js
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('login-form').addEventListener('submit', function(e) {
        e.preventDefault();  // Prevent the default form submission

        var email = document.getElementsByName('email')[0].value;
        var password = document.getElementsByName('password')[0].value;

        // Define your users and credentials
        var users = {
            'alicej@email.com': {'password': 'alicej', 'name': 'Alice'},
            'janesmith@email.com': {'password': 'janes', 'name': 'Jane'},
            'johndoe@email.com': {'password': 'johnd', 'name': 'John'}
        };

        // Check if the credentials are correct
        var user = users[email];
        if (user && user.password === password) {
            // When authentication is successful, send the user's name to the server to start the session
            fetch('/start_session', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `user_name=${encodeURIComponent(user.name)}`
            })
            .then(response => {
                if (response.ok) {
                    window.location.href = '/homepage';
                } else {
                    throw new Error('Failed to start session.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to start session.');
            });
        } else {
            // Show an error message or handle invalid credentials
            alert('Invalid credentials. Please try again.');
        }
    });
});
