const pool = require('../config/database');

class TicketRepository {
  // Crear compra con transacción segura (previene doble venta)
  async createPurchase(matchId, sectorId, buyerId, quantity, totalPrice, qrCode) {
    const client = await pool.connect();
    
    try {
      // Iniciar transacción
      await client.query('BEGIN');
      
      // 1. Bloquear el sector para evitar que otros lo modifiquen (SELECT FOR UPDATE)
      const sectorQuery = `
        SELECT id, capacity, sold, is_available
        FROM sectors
        WHERE id = $1 AND match_id = $2
        FOR UPDATE
      `;
      const sectorResult = await client.query(sectorQuery, [sectorId, matchId]);
      
      if (sectorResult.rows.length === 0) {
        throw new Error('Sector no encontrado');
      }
      
      const sector = sectorResult.rows[0];
      
      // 2. Validar que haya stock suficiente
      const availableSlots = sector.capacity - sector.sold;
      if (availableSlots < quantity) {
        throw new Error(`Solo quedan ${availableSlots} entradas disponibles`);
      }
      
      // 3. Validar que el sector esté disponible
      if (!sector.is_available) {
        throw new Error('Sector no disponible');
      }
      
      // 4. Actualizar el stock (incrementar vendidos)
      const updateSectorQuery = `
        UPDATE sectors
        SET sold = sold + $1,
            is_available = CASE WHEN (sold + $1) >= capacity THEN false ELSE is_available END
        WHERE id = $2
        RETURNING sold, capacity
      `;
      await client.query(updateSectorQuery, [quantity, sectorId]);
      
      // 5. Crear la entrada
      const insertTicketQuery = `
        INSERT INTO tickets (match_id, sector_id, buyer_id, quantity, total_price, qr_code, status)
        VALUES ($1, $2, $3, $4, $5, $6, 'active')
        RETURNING id
      `;
      const ticketResult = await client.query(insertTicketQuery, [
        matchId, sectorId, buyerId, quantity, totalPrice, qrCode
      ]);
      
      // 6. Confirmar transacción
      await client.query('COMMIT');
      
      return {
        ticketId: ticketResult.rows[0].id,
        qrCode,
        quantity,
        totalPrice
      };
      
    } catch (error) {
      // Revertir transacción en caso de error
      await client.query('ROLLBACK');
      throw error;
    } finally {
      // Liberar conexión al pool
      client.release();
    }
  }

  // Obtener entradas de un comprador
  async getTicketsByBuyerId(buyerId) {
    const query = `
      SELECT 
        t.id, t.quantity, t.total_price, t.qr_code, t.purchase_date, t.status,
        m.home_team, m.away_team, m.match_date, m.stadium,
        s.name as sector_name
      FROM tickets t
      JOIN matches m ON t.match_id = m.id
      JOIN sectors s ON t.sector_id = s.id
      WHERE t.buyer_id = $1
      ORDER BY t.purchase_date DESC
    `;
    
    const result = await pool.query(query, [buyerId]);
    return result.rows;
  }
}

module.exports = new TicketRepository();