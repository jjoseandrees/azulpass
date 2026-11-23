const ticketService = require('../services/ticketService');
const { validateRut } = require('../utils/rutValidator');

class TicketController {
  async processPurchase(req, res, next) {
    try {
      const { matchId, sectorId, quantity, buyerRut, buyerName, buyerEmail, buyerPhone } = req.body;

      // Validación de campos obligatorios
      if (!matchId || !sectorId || !quantity || !buyerRut) {
        return res.status(400).json({ 
          success: false, 
          error: 'Datos incompletos. Se requiere: matchId, sectorId, quantity, buyerRut' 
        });
      }

      // VALIDACIÓN DE RUT
      if (!validateRut(buyerRut)) {
        return res.status(400).json({ 
          success: false, 
          error: `RUT inválido: "${buyerRut}". Formato esperado: XX.XXX.XXX-X` 
        });
      }

      // Validar cantidad (regla de negocio)
      const qty = parseInt(quantity);
      if (qty < 1 || qty > 4) {
        return res.status(400).json({ 
          success: false, 
          error: 'Cantidad inválida. Mínimo 1, máximo 4 entradas por compra.' 
        });
      }

      const result = await ticketService.processPurchase({
        matchId: parseInt(matchId),
        sectorId: parseInt(sectorId),
        quantity: qty,
        buyerRut,
        buyerName,
        buyerEmail,
        buyerPhone
      });

      res.status(201).json({ success: true, data: result });
    } catch (error) {
      next(error);
    }
  }

  async getUserTickets(req, res, next) {
    try {
      const { rut } = req.params;
      
      if (!rut) {
        return res.status(400).json({ 
          success: false, 
          error: 'RUT requerido' 
        });
      }

      // Validar RUT también al consultar
      if (!validateRut(rut)) {
        return res.status(400).json({ 
          success: false, 
          error: `RUT inválido: "${rut}"` 
        });
      }

      const tickets = await ticketService.getUserTickets(rut);
      
      res.json({ 
        success: true, 
        data: tickets,
        count: tickets.length 
      });
    } catch (error) {
      next(error);
    }
  }

  async getMyTickets(req, res, next) {
    try {
      // req.user viene del middleware de autenticación
      const buyerRut = req.user.rut;

      const tickets = await ticketService.getUserTickets(buyerRut);

      res.json({
        success: true,
        data: tickets,
        count: tickets.length
      });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = new TicketController();