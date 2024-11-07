const mysql = require('mysql2/promise');

exports.handler = async () => {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
        ssl: { rejectUnauthorized: true } // Adjust as needed for SSL
    });

    try {
        const [rows] = await connection.execute('SELECT * FROM your_table');
        return { statusCode: 200, body: JSON.stringify(rows) };
    } catch (error) {
        return { statusCode: 500, body: JSON.stringify(error) };
    } finally {
        await connection.end();
    }
};
