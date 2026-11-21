const ticketRepository = require('../repositories/ticketRepository');
const buyerService = require('./buyerService');
const crypto = require('crypto');

class TicketService {
  async processPurchase({ matchId, sectorId, quantity, buyerRut, buyerName, buyerEmail, buyerPhone }) {
    // 1. Validaciones básicas de negocio
    if (quantity < 1 || quantity > 4) throw new Error('Cantidad inválida (máx 4)');
    
    // 2. Asegurar que el comprador existe en la BD
    const buyer = await buyerService.findOrCreate(buyerRut, buyerName, buyerEmail, buyerPhone);

    // 3. Calcular precio (En producción, esto viene validado del sector en BD, aquí lo simulamos o lo traemos)
    // Para simplificar y ser rápidos, asumimos que el frontend envía el total, pero en producción se recalcula en BD.
    // Aquí generamos un QR único y seguro
    const qrCode = `AZUL-${matchId}-${sectorId}-${buyer.id}-${crypto.randomBytes(8).toString('hex')}`;
    
    // Precio simulado (En producción: traer precio real del sector en la transacción)
    const mockPricePerTicket = 15000; 
    const totalPrice = mockPricePerTicket * quantity;

    // 4. Ejecutar compra segura
    const ticket = await ticketRepository.createPurchase(
      matchId, sectorId, buyer.id, quantity, totalPrice, qrCode
    );

    return { ...ticket, buyerRut: buyer.rut, buyerName: buyer.full_name };
  }

  async getUserTickets(rut) {
    const buyer = await buyerService.findOrCreate(rut, '', '', ''); // Solo para obtener el ID
    if (!buyer) return [];
    return await ticketRepository.getTicketsByBuyerId(buyer.id);
  }
}

module.exports = new TicketService();