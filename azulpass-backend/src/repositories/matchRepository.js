const pool = require('../config/database');

class MatchRepository {
  // Obtener todos los partidos próximos
  async getUpcomingMatches() {
    const query = `
      SELECT 
        id, home_team, away_team, match_date, stadium, 
        competition, status, requirements, sale_phases
      FROM matches
      WHERE status = 'upcoming'
      ORDER BY match_date ASC
    `;
    
    const result = await pool.query(query);
    return result.rows;
  }

  // Obtener partido por ID
  async getMatchById(id) {
    const query = `
      SELECT 
        id, home_team, away_team, match_date, stadium, 
        competition, status, requirements, sale_phases
      FROM matches
      WHERE id = $1 AND status = 'upcoming'
    `;
    
    const result = await pool.query(query, [id]);
    return result.rows[0] || null;
  }

  // Obtener sectores de un partido
  async getSectorsByMatchId(matchId) {
    const query = `
      SELECT id, name, price, is_available, capacity, sold
      FROM sectors
      WHERE match_id = $1
      ORDER BY name ASC
    `;
    
    const result = await pool.query(query, [matchId]);
    return result.rows;
  }
}

module.exports = new MatchRepository();