const buyerRepository = require('../repositories/buyerRepository');

class BuyerService {
  // Busca al comprador, si no existe lo crea (Idempotencia para el flujo de compra)
  async findOrCreate(rut, fullName, email, phone) {
    let buyer = await buyerRepository.findByRut(rut);
    
    if (!buyer) {
      buyer = await buyerRepository.create({ rut, fullName, email, phone });
    }
    
    return buyer;
  }
}

module.exports = new BuyerService();