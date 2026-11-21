const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const { generalLimiter, purchaseLimiter } = require('./middleware/rateLimiter');
const matchRoutes = require('./routes/matchRoutes');
const ticketRoutes = require('./routes/ticketRoutes');
const buyerRoutes = require('./routes/buyerRoutes');
const errorHandler = require('./middleware/errorHandler');
const env = require('./config/env');

const app = express();

// ============ SEGURIDAD ============
app.use(helmet());

app.use((req, res, next) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  next();
});

// CORS configurado para producción
const corsOptions = {
  origin: env.nodeEnv === 'production' 
    ? ['https://azulpass.cl', 'https://www.azulpass.cl'] // Esta URL es de ejemplo
    : ['http://localhost:3000', 'http://localhost:8080'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
};
app.use(cors(corsOptions));

// Parsear JSON con límite
app.use(express.json({ limit: '10kb' }));

// ============ RATE LIMITING ============
app.use('/api/', generalLimiter); // Aplicar a todas las rutas API

// ============ RUTAS ============
app.use('/api/matches', matchRoutes);
app.use('/api/tickets', ticketRoutes); // Rate limiter estricto para compras
app.use('/api/buyers', buyerRoutes); // Rutas de compradores (si se expanden en el futuro)

// Health check
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    environment: env.nodeEnv
  });
});

// ============ MANEJO DE ERRORES ============
app.use(errorHandler);

// 404 handler
app.use((req, res) => {
  res.status(404).json({ 
    success: false, 
    error: 'Ruta no encontrada' 
  });
});

app.listen(env.port, () => {
  console.log(`🚀 Servidor corriendo en puerto ${env.port}`);
  console.log(`📝 Entorno: ${env.nodeEnv}`);
  console.log(`🔒 Rate limiting activado`);
});

module.exports = app;