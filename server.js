const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(cors());
app.use(express.static('public'));

// Database connection configuration
const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: 'Dbalab@123', // Update as needed
    database: 'ckm', // Update as needed
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
};

const db = mysql.createPool(dbConfig);

// Route for the default page (auth.html)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'auth.html'));
});

// Route for signing in
app.post('/signin', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [rows] = await db.query(
            'SELECT * FROM customer_details WHERE Username = ? AND Password = ?',
            [username, password]
        );
        if (rows.length > 0) {
            res.json({ success: true, message: 'Sign in successful' });
        } else {
            res.json({ success: false, message: 'Invalid username or password' });
        }
    } catch (error) {
        console.error('Error during sign in:', error);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
});

// Route for signing up
app.post('/signup', async (req, res) => {
    const { username, password, mobile, email } = req.body;
    try {
        await db.query(
            'INSERT INTO customer_details (Username, Password, Mobile_NO, Email_ID) VALUES (?, ?, ?, ?)',
            [username, password, mobile, email]
        );
        res.json({ success: true, message: 'Sign up successful' });
    } catch (error) {
        console.error('Error during sign up:', error);
        if (error.code === 'ER_DUP_ENTRY') {
            res.status(400).json({ success: false, message: 'Username already exists' });
        } else {
            res.status(500).json({ success: false, message: 'Internal server error' });
        }
    }
});

// Route for logging out
app.post('/logout', (req, res) => {
    res.json({ success: true, message: 'Logged out successfully' });
});

// Route to fetch menu items
app.get('/menu', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM menu');
        res.json(rows);
    } catch (err) {
        console.error('Error fetching menu:', err);
        res.status(500).json({ error: 'Failed to fetch menu' });
    }
});

// Route to handle placing an order
app.post('/place-order', async (req, res) => {
    const { cart, address } = req.body;

    if (!cart || cart.length === 0) {
        return res.status(400).json({ error: 'No items in the cart' });
    }

    try {
        // Calculate the total amount for the order
        let totalAmount = 0;
        cart.forEach(item => {
            totalAmount += item.Item_Price * item.quantity;
        });

        // Insert a new order into the 'orders' table
        const [orderResult] = await db.query(
            'INSERT INTO orders (Customer_ID, Total_Ammount, Address) VALUES (?, ?, ?)',
            [7, totalAmount, address]
        );
        const orderId = orderResult.insertId;

        // Insert items into the 'ordered_items' table, including their quantity
        for (let item of cart) {
            await db.query(
                'INSERT INTO ordered_items (Order_ID, Item_ID, Quantity) VALUES (?, ?, ?)',
                [orderId, item.Item_ID, item.quantity]
            );
        }

        res.status(200).json({ message: 'Order placed successfully' });

    } catch (err) {
        console.error('Error placing order:', err);
        res.status(500).json({ error: 'Failed to place the order' });
    }
});

// Route to serve the checkout page
app.get('/checkout', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'checkout.html'));
});


// Starting the server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
