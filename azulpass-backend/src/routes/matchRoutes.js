const express = require('express');
const router = express.Router();
const matchController = require('../controllers/matchController');

// GET /api/matches - Lista de partidos próximos
router.get('/', matchController.getUpcomingMatches);

// GET /api/matches/:id - Detalle de un partido
router.get('/:id', matchController.getMatchById);

module.exports = router;