const express = require('express');
const router = express.Router();
const ticketController = require('../controllers/ticketController');
const authenticateToken = require('../middleware/auth');

// Obtener entradas del usuario autenticado
router.get('/my-tickets', authenticateToken, ticketController.getMyTickets);

// Procesar compra de entradas
router.post('/purchase', ticketController.processPurchase);

module.exports = router;