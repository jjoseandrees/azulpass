// Manejo global de errores
function errorHandler(err, req, res, next) {
  console.error('❌ Error:', err.message);
  
  // En desarrollo, mostrar el error completo
  if (process.env.NODE_ENV === 'development') {
    return res.status(500).json({
      success: false,
      error: err.message,
      stack: err.stack
    });
  }

  // En producción, mensaje genérico (seguridad)
  res.status(500).json({
    success: false,
    error: 'Error interno del servidor'
  });
}

module.exports = errorHandler;