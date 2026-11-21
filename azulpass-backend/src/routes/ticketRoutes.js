const express = require('express');
const router = express.Router();
const ticketController = require('../controllers/ticketController');

// GET /api/tickets - Obtener entradas del usuario
router.get('/', ticketController.getUserTickets);

// POST /api/tickets/purchase - Procesar compra de entradas
router.post('/purchase', ticketController.processPurchase);

module.exports = router;