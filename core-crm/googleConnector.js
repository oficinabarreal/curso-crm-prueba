const { google } = require('googleapis');
const path = require('path');
require('dotenv').config();

const auth = new google.auth.GoogleAuth({
    keyFile: path.join(__dirname, '../credentials.json'),
    scopes: [
        'https://www.googleapis.com/auth/spreadsheets',
        'https://www.googleapis.com/auth/calendar'
    ],
});

async function obtenerClienteGoogle() {
    const authClient = await auth.getClient();
    return authClient;
}

module.exports = { obtenerClienteGoogle };
