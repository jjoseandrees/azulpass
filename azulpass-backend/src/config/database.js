const { Pool } = require('pg');
const env = require('./env');

// Pool de conexiones optimizado para picos de demanda
const pool = new Pool({
  host: env.db.host,
  port: env.db.port,
  database: env.db.database,
  user: env.db.user,
  password: env.db.password,
  max: 50,
  min: 5,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
  maxUses: 7500, // Reciclar conexiones después de 7500 usos para evitar fugas de memoria
  client_encoding: 'utf8',

  allowExitOnIdle: false, // Evitar que el pool cierre conexiones automáticamente
});

// Monitoreo de conexiones
pool.on('connect', () => {
  console.log('✅ Nueva conexión a PostgreSQL');
});

pool.on('acquire', () => {
  // Descomenta en desarrollo para debug
  // console.log('Conexión adquirida del pool');
});

pool.on('error', (err) => {
  console.error('❌ Error inesperado en el pool de PostgreSQL:', err);
  // No salir del proceso, intentar reconectar
});

// Función para obtener estadísticas del pool (útil para monitoreo)
pool.getStats = () => ({
  totalCount: pool.totalCount,
  idleCount: pool.idleCount,
  waitingCount: pool.waitingCount,
});

module.exports = pool;