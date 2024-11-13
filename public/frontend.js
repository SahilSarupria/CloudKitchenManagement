function toggleForms() {
    const signinForm = document.getElementById('signin-form');
    const signupForm = document.getElementById('signup-form');
    const message = document.getElementById('message');

    signinForm.style.display = signinForm.style.display === 'none' ? 'block' : 'none';
    signupForm.style.display = signupForm.style.display === 'none' ? 'block' : 'none';
    message.textContent = '';
    message.className = 'error';
}

function togglePassword(inputId, toggleId) {
    const passwordInput = document.getElementById(inputId);
    const toggleButton = document.querySelector(`[onclick="togglePassword('${inputId}', '${toggleId}')"]`);

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleButton.textContent = '🔒';
    } else {
        passwordInput.type = 'password';
        toggleButton.textContent = '👁️';
    }
}

async function signIn(event) {
    event.preventDefault();
    const username = document.getElementById('signin-username').value;
    const password = document.getElementById('signin-password').value;

    try {
        const response = await fetch('http://localhost:3000/signin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, password }),
        });
        const data = await response.json();
        const message = document.getElementById('message');
        message.textContent = data.message;
        message.className = data.success ? 'success' : 'error';

        if (data.success) {
            // Redirect to menu.html on successful sign-in
            window.location.href = 'menu.html';
        }
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'An error occurred. Please try again.';
    }
}

async function signUp(event) {
    event.preventDefault();
    const username = document.getElementById('signup-username').value;
    const password = document.getElementById('signup-password').value;
    const mobile = document.getElementById('signup-mobile').value;
    const email = document.getElementById('signup-email').value;

    try {
        const response = await fetch('http://localhost:3000/signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, password, mobile, email }),
        });
        const data = await response.json();
        const message = document.getElementById('message');
        message.textContent = data.message;
        message.className = data.success ? 'success' : 'error';

        if (data.success) {
            toggleForms(); // Switch to sign-in form after successful sign-up
        }
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'An error occurred. Please try again.';
    }
}
