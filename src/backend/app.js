require('dotenv').config();
const express = require("express");
const cors = require("cors");
const mysql = require('mysql2/promise');

const app = express();
const port = 3000;

// Database configuration
const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
};

// Initialize database connection
async function initializeDatabase() {
    try {
        // First connect without database to create it if needed
        const adminConnection = await mysql.createConnection({
            host: dbConfig.host,
            user: dbConfig.user,
            password: dbConfig.password
        });

        // Create database if it doesn't exist
        await adminConnection.query(`CREATE DATABASE IF NOT EXISTS \`$${process.env.DB_NAME}\`;`);
        await adminConnection.end();

        // Now connect to the specific database
        const connection = await mysql.createConnection(dbConfig);

        // Create table if it doesn't exist
        await connection.query(`
            CREATE TABLE IF NOT EXISTS counters (
                id VARCHAR(255) PRIMARY KEY,
                value INT NOT NULL DEFAULT 0,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            );
        `);

        console.log('Database initialized successfully');
        return connection;
    } catch (error) {
        console.error('Database initialization failed:', error);
        throw error;
    }
}

// Middleware
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST"],
  })
);
app.use(express.json());

// Initialize database connection when starting the app
let dbConnection;
initializeDatabase().then(connection => {
    dbConnection = connection;
}).catch(err => {
    console.error('Failed to initialize database:', err);
    process.exit(1);
});

// Get current counter value and increment it
app.get("/api/increment", async (req, res) => {
    if (!dbConnection) {
        return res.status(500).json({ error: "Database not connected" });
    }

    try {
        const counterId = 'main_counter'; // You can make this dynamic if needed
        
        // First ensure the counter exists
        const [rows] = await dbConnection.query(
            'SELECT value FROM counters WHERE id = ?',
            [counterId]
        );
        
        if (rows.length === 0) {
            // If counter doesn't exist, initialize it with 0
            await dbConnection.query(
                'INSERT INTO counters (id, value) VALUES (?, ?)',
                [counterId, 0]
            );
        }
        
        // Increment the counter
        await dbConnection.query(
            'UPDATE counters SET value = value + 1 WHERE id = ?',
            [counterId]
        );
        
        // Get the new value
        const [updatedRows] = await dbConnection.query(
            'SELECT value FROM counters WHERE id = ?',
            [counterId]
        );
        
        res.json({ counter: updatedRows[0].value });
    } catch (error) {
        console.error('Error incrementing counter:', error);
        res.status(500).json({ error: error.message });
    }
});

// Health check endpoint
app.get("/api/health", (req, res) => {
    res.json({ status: "healthy" });
});

// Start the server
app.listen(port, "0.0.0.0", () => {
    console.log(`Backend API listening at http://0.0.0.0:3000`);
});

// Graceful shutdown
process.on('SIGTERM', async () => {
    if (dbConnection) {
        await dbConnection.end();
    }
    process.exit(0);
});

process.on('SIGINT', async () => {
    if (dbConnection) {
        await dbConnection.end();
    }
    process.exit(0);
});