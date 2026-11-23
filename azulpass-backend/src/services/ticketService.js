const ticketRepository = require('../repositories/ticketRepository');
const buyerService = require('../services/buyerService');
const emailService = require('./emailService');
const crypto = require('crypto');
const { validateRut } = require('../utils/rutValidator');

class TicketService {
async processPurchase({ matchId, sectorId, quantity, buyerRut, buyerName, buyerEmail, buyerPhone }) {
  if (!validateRut(buyerRut)) {
    throw new Error(`RUT inválido: ${buyerRut}`);
  }

  if (quantity < 1 || quantity > 4) {
    throw new Error('Cantidad inválida (máx 4)');
  }

  const buyer = await buyerService.findOrCreate(buyerRut, buyerName, buyerEmail, buyerPhone);
  const qrCode = `AZUL-${matchId}-${sectorId}-${buyer.id}-${crypto.randomBytes(8).toString('hex')}`;

  const mockPricePerTicket = 15000;
  const totalPrice = mockPricePerTicket * quantity;

  const ticket = await ticketRepository.createPurchase(
    matchId, sectorId, buyer.id, quantity, totalPrice, qrCode
  );

  const ticketId = ticket.id || ticket.ticketId;

  if (ticketId) {
    const ticketDetails = await ticketRepository.getTicketDetailsById(ticketId);
    await emailService.sendPurchaseConfirmation(buyerEmail, buyer.full_name, ticketDetails);
  }

  return { ...ticket, buyerRut: buyer.rut, buyerName: buyer.full_name };
}

  async getUserTickets(rut) {
    if (!validateRut(rut)) {
      throw new Error(`RUT inválido: ${rut}`);
    }

    const buyer = await buyerService.findByRut(rut);
    
    if (!buyer) {
      return [];
    }
    
    return await ticketRepository.getTicketsByBuyerId(buyer.id);
  }
}

module.exports = new TicketService();