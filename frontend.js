// public/frontend.js
let cart = [];

document.addEventListener('DOMContentLoaded', () => {
    fetchMenu(); // Fetch menu items when the page is loaded
});

// Fetch menu items from the server and display them
async function fetchMenu() {
    try {
        const response = await fetch('/menu');
        const menuItems = await response.json();
        const menuContainer = document.getElementById('menu-container');
        
        // Create and display a card for each menu item
        menuItems.forEach(item => {
            const card = createCard(item);
            menuContainer.appendChild(card);
        });
    } catch (error) {
        console.error('Error fetching menu:', error);
    }
}

// Create an individual card for each menu item
function createCard(item) {
    const card = document.createElement('div');
    card.className = 'card';

    const itemName = document.createElement('h3');
    itemName.textContent = item.Item_Name;

    const itemType = document.createElement('p');
    itemType.textContent = `Type: ${item.Item_Type}`;

    const itemDescription = document.createElement('p');
    itemDescription.textContent = item.Description;

    const itemPrice = document.createElement('p');
    itemPrice.className = 'price';
    itemPrice.textContent = `₹ ${item.Item_Price}`;

    // Create quantity input field
    const quantityLabel = document.createElement('label');
    quantityLabel.textContent = 'Quantity:';
    const quantityInput = document.createElement('input');
    quantityInput.type = 'number';
    quantityInput.value = 0; // Default value is 0
    quantityInput.min = 0; // Ensure no negative quantities
    quantityInput.id = `quantity-${item.Item_ID}`;

    const addToCartButton = document.createElement('button');
    addToCartButton.textContent = 'Add to Cart';
    addToCartButton.onclick = () => addToCart(item, quantityInput);

    card.appendChild(itemName);
    card.appendChild(itemType);
    card.appendChild(itemDescription);
    card.appendChild(itemPrice);
    card.appendChild(quantityLabel);
    card.appendChild(quantityInput);
    card.appendChild(addToCartButton);

    return card;
}

// Add an item to the cart with the selected quantity
function addToCart(item, quantityInput) {
    const quantity = parseInt(quantityInput.value, 10); // Get the quantity from the input field
    if (quantity > 0) { // Only add to the cart if quantity is greater than 0
        cart.push({ ...item, quantity: quantity });
        alert(`${item.Item_Name} (x${quantity}) has been added to your cart!`);
    } else {
        alert('Please select a quantity greater than 0.');
    }
}

// Handle the global place order button click (top-right)
async function placeOrder() {
    if (cart.length === 0) {
        alert('Your cart is empty!');
        return;
    }

    const deliveryAddress = prompt('Please enter your delivery address:');
    
    if (deliveryAddress) {
        // Send the cart data and delivery address to the backend
        const response = await fetch('/place-order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                cart: cart,
                address: deliveryAddress
            })
        });

        const result = await response.json();
        
        if (response.status === 200) {
            alert('Order placed successfully!');
            console.log('Ordered Items:', cart);
            console.log('Total Amount:', cart.reduce((total, item) => total + (item.Item_Price * item.quantity), 0));
            cart = []; // Clear the cart after a successful order
        } else {
            alert(`Error: ${result.error}`);
        }
    } else {
        alert('Delivery address is required to place the order!');
    }
}

// Create a global "Place Order" button (top-right of the page)
function createGlobalPlaceOrderButton() {
    const placeOrderButton = document.createElement('button');
    placeOrderButton.textContent = 'Place Order';
    placeOrderButton.className = 'global-place-order';
    placeOrderButton.onclick = placeOrder;

    document.body.appendChild(placeOrderButton);
}

// Initialize the global place order button
createGlobalPlaceOrderButton();


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
        const response = await fetch('mysql://avnadmin:AVNS_-uHGt7At2jCqPOz_VII@mysql-8e29e85-cloudkitchen-01.k.aivencloud.com:19129/cloud_kitchen_management?ssl-mode=REQUIRED', {
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
            document.getElementById('auth-forms').style.display = 'none';
            document.getElementById('welcome-page').style.display = 'block';
            document.getElementById('welcome-username').textContent = username;
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
        const response = await fetch('mysql://avnadmin:AVNS_-uHGt7At2jCqPOz_VII@mysql-8e29e85-cloudkitchen-01.k.aivencloud.com:19129/cloud_kitchen_management?ssl-mode=REQUIRED', {
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
    } catch (error) {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'An error occurred. Please try again.';
    }
}

function logout() {
    document.getElementById('auth-forms').style.display = 'block';
    document.getElementById('welcome-page').style.display = 'none';
    document.getElementById('signin-username').value = '';
    document.getElementById('signin-password').value = '';
    document.getElementById('message').textContent = '';
}
