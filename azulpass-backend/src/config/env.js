require('dotenv').config();

const requiredEnvVars = [
  'DB_HOST',
  'DB_PORT',
  'DB_NAME',
  'DB_USER',
  'DB_PASSWORD',
  'JWT_SECRET',
  'PORT',
  'NODE_ENV'
];

const missingVars = requiredEnvVars.filter(varName => !process.env[varName]);

if (missingVars.length > 0) {
  console.error('❌ Faltan variables de entorno:', missingVars.join(', '));
  console.error('Copia .env.example a .env y completa los valores');
  process.exit(1);
}

// Validar que JWT_SECRET sea suficientemente largo
if (process.env.JWT_SECRET.length < 32) {
  console.error('❌ JWT_SECRET debe tener al menos 32 caracteres');
  process.exit(1);
}

// Validar entorno
if (!['development', 'production', 'test'].includes(process.env.NODE_ENV)) {
  console.error('❌ NODE_ENV debe ser: development, production o test');
  process.exit(1);
}

module.exports = {
  db: {
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT),
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
  },
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: '24h'
  },
  port: parseInt(process.env.PORT),
  nodeEnv: process.env.NODE_ENV,
};