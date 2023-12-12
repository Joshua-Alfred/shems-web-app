// static/login.js
function checkCredentials() {
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    
    // Hardcoded credentials for simplicity
    var users = [
        { email: 'alicej@email.com', password: 'alicej', name: 'Alice' },
        { email: 'janesmith@email.com', password: 'janes', name: 'Jane' },
        { email: 'johndoe@email.com', password: 'johnd', name: 'John' }
    ];

    var authenticatedUser = users.find(user => user.email === email && user.password === password);

    if (authenticatedUser) {
        // Store authenticated user's first name in session storage
        sessionStorage.setItem('userName', authenticatedUser.name);
        window.location.href = '/homepage'; // Redirect to homepage route in Flask

    } else {
        alert('Incorrect email or password. Please try again.');
    }
}
