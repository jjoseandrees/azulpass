const ticketService = require('../services/ticketService');

class TicketController {
  async processPurchase(req, res, next) {
    try {
      const { matchId, sectorId, quantity, buyerRut, buyerName, buyerEmail, buyerPhone } = req.body;

      // Validación de seguridad: Sanitizar inputs
      if (!matchId || !sectorId || !quantity || !buyerRut) {
        return res.status(400).json({ success: false, error: 'Datos incompletos' });
      }

      const result = await ticketService.processPurchase({
        matchId: parseInt(matchId),
        sectorId: parseInt(sectorId),
        quantity: parseInt(quantity),
        buyerRut, buyerName, buyerEmail, buyerPhone
      });

      res.status(201).json({ success: true, data: result });
    } catch (error) {
      next(error);
    }
  }

  async getUserTickets(req, res, next) {
    try {
      // En el futuro usaremos el JWT para obtener el RUT. Por ahora, lo recibimos por query param para probar
      const { rut } = req.query;
      if (!rut) return res.status(400).json({ success: false, error: 'RUT requerido' });

      const tickets = await ticketService.getUserTickets(rut);
      res.json({ success: true, data: tickets });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = new TicketController();