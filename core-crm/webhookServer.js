const express = require('express');
require('dotenv').config();

const app = express();
app.use(express.json());

// Verificación Webhook Meta
app.get('/webhook', (req, res) => {
    const mode = req.query['hub.mode'];
    const token = req.query['hub.verify_token'];
    const challenge = req.query['hub.challenge'];

    if (mode && token) {
        if (mode === 'subscribe' && token === process.env.META_VERIFY_TOKEN) {
            console.log('Webhook verificado con Meta');
            return res.status(200).send(challenge);
        }
        return res.sendStatus(403);
    }
});

// Recepción de mensajes
app.post('/webhook', (req, res) => {
    const body = req.body;
    if (body.object) {
        console.log('Mensaje recibido:', JSON.stringify(body, null, 2));
        return res.status(200).send('EVENT_RECEIVED');
    }
    return res.sendStatus(404);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor Webhook en puerto ${PORT}`));
