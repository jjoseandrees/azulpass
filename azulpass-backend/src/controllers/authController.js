const buyerRepository = require('../repositories/buyerRepository');
const jwt = require('jsonwebtoken');

class AuthController {
  async login(req, res, next) {
    try {
      const { rut } = req.body;

      if (!rut) {
        return res.status(400).json({ success: false, error: 'RUT requerido' });
      }

      // Buscar comprador por RUT
      const buyer = await buyerRepository.findByRut(rut);

      if (!buyer) {
        return res.status(404).json({ success: false, error: 'Comprador no encontrado' });
      }

      // Generar token JWT
      const token = jwt.sign(
        { id: buyer.id, rut: buyer.rut, name: buyer.full_name },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.json({
        success: true,
        data: {
          token,
          buyer: {
            id: buyer.id,
            rut: buyer.rut,
            name: buyer.full_name,
            email: buyer.email
          }
        }
      });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = new AuthController();