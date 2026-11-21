const rateLimit = require('express-rate-limit');

// Rate limiter general (prevenir DoS)
const generalLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 100, // 100 requests por IP cada 15 minutos
  message: {
    success: false,
    error: 'Demasiadas peticiones, intenta de nuevo en 15 minutos'
  },
  standardHeaders: true,
  legacyHeaders: false,
});

// Rate limiter estricto para compra de entradas (prevenir bots)
const purchaseLimiter = rateLimit({
  windowMs: 5 * 60 * 1000, // 5 minutos
  max: 5, // Solo 5 intentos de compra cada 5 minutos por IP
  message: {
    success: false,
    error: 'Demasiados intentos de compra. Espera 5 minutos.'
  },
  standardHeaders: true,
  legacyHeaders: false,
});

module.exports = { generalLimiter, purchaseLimiter };