const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// POST /api/auth/login - Login con RUT
router.post('/login', authController.login);

module.exports = router;