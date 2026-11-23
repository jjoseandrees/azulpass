const http = require('http');

// Configuración de la prueba
const CONFIG = {
  host: 'localhost',
  port: 3000,
  path: '/api/tickets/purchase',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json; charset=utf-8'
  },
  // Datos de prueba
  matchId: 1,
  sectorId: 6, 
  quantity: 1,
  buyerName: 'Test User',
  buyerEmail: 'test@test.com',
  buyerPhone: '+56900000000'
};

// Generar RUTs válidos aleatorios para la prueba
function generateValidRut() {
  const body = Math.floor(Math.random() * 90000000) + 10000000;
  let sum = 0;
  let multiplier = 2;
  
  for (let i = body.toString().length - 1; i >= 0; i--) {
    sum += parseInt(body.toString()[i]) * multiplier;
    multiplier = multiplier === 7 ? 2 : multiplier + 1;
  }
  
  const remainder = 11 - (sum % 11);
  let dv = remainder === 11 ? '0' : remainder === 10 ? 'K' : remainder.toString();
  
  return `${body.toString().slice(0, 2)}.${body.toString().slice(2, 5)}.${body.toString().slice(5)}-${dv}`;
}

// Generar email único basado en el RUT
function generateUniqueEmail(rut) {
  const cleanRut = rut.replace(/\./g, '').replace(/-/g, '');
  return `hincha${cleanRut}@test.com`;
}

function makePurchase(rut) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      matchId: CONFIG.matchId,
      sectorId: CONFIG.sectorId,
      quantity: CONFIG.quantity,
      buyerRut: rut,
      buyerName: CONFIG.buyerName,
      buyerEmail: generateUniqueEmail(rut),
      buyerPhone: CONFIG.buyerPhone
    });

    const req = http.request({
      hostname: CONFIG.host,
      port: CONFIG.port,
      path: CONFIG.path,
      method: CONFIG.method,
      headers: {
        ...CONFIG.headers,
        'Content-Length': Buffer.byteLength(data)
      }
    }, (res) => {
      let body = '';
      res.on('data', (chunk) => body += chunk);
      res.on('end', () => {
        const response = JSON.parse(body);
        resolve({
          status: res.statusCode,
          success: response.success,
          error: response.error,
          ticketId: response.data?.id
        });
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// Ejecutar prueba de concurrencia
async function runConcurrencyTest() {
  const totalRequests = 20; // 20 compras simultáneas
  const results = {
    success: 0,
    failed: 0,
    errors: []
  };

  console.log('🚀 Iniciando prueba de concurrencia...');
  console.log(`📊 Total de peticiones: ${totalRequests}`);
  console.log(`🎯 Sector: ${CONFIG.sectorId} (Galería Andes)`);
  console.log('⏱️  Ejecutando peticiones simultáneas...\n');

  const startTime = Date.now();

  // Crear array de promesas para ejecutar todas simultáneamente
  const promises = Array.from({ length: totalRequests }, (_, i) => {
    const rut = generateValidRut();
    return makePurchase(rut)
      .then(result => {
        if (result.success) {
          results.success++;
          console.log(`✅ Petición ${i + 1}: RUT ${rut} - Ticket #${result.ticketId}`);
        } else {
          results.failed++;
          results.errors.push({ rut, error: result.error });
          console.log(`❌ Petición ${i + 1}: RUT ${rut} - ${result.error}`);
        }
      })
      .catch(err => {
        results.failed++;
        results.errors.push({ rut, error: err.message });
        console.log(`💥 Petición ${i + 1}: RUT ${rut} - Error: ${err.message}`);
      });
  });

  // Esperar a que todas terminen
  await Promise.all(promises);

  const endTime = Date.now();
  const duration = ((endTime - startTime) / 1000).toFixed(2);

  console.log('\n' + '='.repeat(60));
  console.log('📈 RESULTADOS DE LA PRUEBA DE CONCURRENCIA');
  console.log('='.repeat(60));
  console.log(`⏱️  Duración total: ${duration} segundos`);
  console.log(`✅ Compras exitosas: ${results.success}`);
  console.log(`❌ Compras fallidas: ${results.failed}`);
  console.log(`📊 Tasa de éxito: ${((results.success / totalRequests) * 100).toFixed(1)}%`);
  console.log('='.repeat(60));

  if (results.errors.length > 0) {
    console.log('\n⚠️  Errores detallados:');
    results.errors.forEach((err, i) => {
      console.log(`   ${i + 1}. RUT ${err.rut}: ${err.error}`);
    });
  }

  console.log('\n✅ Prueba completada. Revisa pgAdmin para verificar que no haya sobreventa.');
}

// Ejecutar la prueba
runConcurrencyTest().catch(console.error);