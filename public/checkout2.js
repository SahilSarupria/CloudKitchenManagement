document.addEventListener('DOMContentLoaded', () => {
    const cartSummary = document.getElementById('cart-summary');
    const checkoutForm = document.getElementById('checkout-form');

    // Retrieve the cart from localStorage
    const cart = JSON.parse(localStorage.getItem('cart')) || [];

    if (cart.length === 0) {
        cartSummary.innerHTML = '<p>Your cart is empty.</p>';
        checkoutForm.style.display = 'none';
        return;
    }

    // Display cart summary
    let totalAmount = 0;
    cart.forEach(item => {
        const itemRow = document.createElement('p');
        itemRow.textContent = `${item.Item_Name} (x${item.quantity}) - ₹${item.Item_Price * item.quantity}`;
        cartSummary.appendChild(itemRow);
        totalAmount += item.Item_Price * item.quantity;
    });

    const totalRow = document.createElement('p');
    totalRow.textContent = `Total Amount: ₹${totalAmount}`;
    cartSummary.appendChild(totalRow);

    // Handle form submission
    checkoutForm.addEventListener('submit', async (event) => {
        event.preventDefault();
        const address = document.getElementById('address').value;

        if (!address) {
            alert('Please select a delivery address.');
            return;
        }

        try {
            const response = await fetch('/place-order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ cart, address }),
            });

            const result = await response.json();

            if (response.status === 200) {
                alert('Order placed successfully!');
                localStorage.removeItem('cart'); // Clear the cart
                window.location.href = '/menu.html'; // Redirect to the main page
            } else {
                alert(`Error: ${result.error}`);
            }
        } catch (error) {
            console.error('Error placing order:', error);
            alert('Failed to place the order. Please try again later.');
        }
    });
});
