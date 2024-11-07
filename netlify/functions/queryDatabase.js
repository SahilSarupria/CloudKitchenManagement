const mysql = require('mysql2');

exports.handler = async (event, context) => {
    const connection = mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    });

    return new Promise((resolve, reject) => {
        connection.query('SELECT * FROM your_table_name', (error, results) => {
            if (error) {
                reject({ statusCode: 500, body: JSON.stringify(error) });
            } else {
                resolve({ statusCode: 200, body: JSON.stringify(results) });
            }
            connection.end();
        });
    });
};
