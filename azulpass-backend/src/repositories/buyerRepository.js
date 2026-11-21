const pool = require('../config/database');

class BuyerRepository {
  async findByRut(rut) {
    const query = 'SELECT id, rut, full_name, email, phone FROM buyers WHERE rut = $1';
    const result = await pool.query(query, [rut]);
    return result.rows[0] || null;
  }

  async create({ rut, fullName, email, phone }) {
    const query = `
      INSERT INTO buyers (rut, full_name, email, phone)
      VALUES ($1, $2, $3, $4)
      RETURNING id, rut, full_name, email, phone
    `;
    const result = await pool.query(query, [rut, fullName, email, phone]);
    return result.rows[0];
  }
}

module.exports = new BuyerRepository();