class EmailService {
  async sendPurchaseConfirmation(buyerEmail, buyerName, ticketData) {
    // Si no hay datos del ticket, no crashear
    if (!ticketData) {
      console.log('⚠️  No se pudieron obtener detalles del ticket para el correo.');
      return false;
    }

    // Valores por defecto para evitar "undefined"
    const homeTeam = ticketData.home_team || 'Equipo Local';
    const awayTeam = ticketData.away_team || 'Equipo Visitante';
    const matchInfo = `${homeTeam} vs ${awayTeam}`;
    
    const fecha = ticketData.match_date 
      ? new Date(ticketData.match_date).toLocaleString('es-CL', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit'
        })
      : 'Fecha por confirmar';
    
    const estadio = ticketData.stadium || 'Estadio por confirmar';
    const sector = ticketData.sector_name || 'Sector por confirmar';
    const quantity = ticketData.quantity || 1;
    const qrCode = ticketData.qr_code || 'QR no disponible';

    console.log('\n' + '='.repeat(60));
    console.log('📧 SIMULACIÓN DE ENVÍO DE CORREO (Entorno de pruebas)');
    console.log('='.repeat(60));
    console.log(`📤 Para: ${buyerEmail}`);
    console.log(`📝 Asunto: ¡Tu entrada para ${matchInfo} está lista!`);
    console.log('-'.repeat(60));
    console.log(`Hola ${buyerName || 'Hincha'},`);
    console.log('');
    console.log('Tu compra fue exitosa. Aquí están los detalles de tu entrada:');
    console.log(`🏟️  Estadio: ${estadio}`);
    console.log(`📅 Fecha: ${fecha}`);
    console.log(`🎟️  Sector: ${sector}`);
    console.log(`🔢 Cantidad: ${quantity}`);
    console.log(`📱 Código QR: ${qrCode}`);
    console.log('');
    console.log('Recuerda llevar tu cédula con chip legible.');
    console.log('¡Nos vemos en el estadio!');
    console.log('='.repeat(60) + '\n');

    return true;
  }
}

module.exports = new EmailService();