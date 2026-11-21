const matchRepository = require('../repositories/matchRepository');

class MatchService {
  async getUpcomingMatches() {
    const matches = await matchRepository.getUpcomingMatches();
    
    // Transformar datos para el frontend
    return matches.map(match => ({
      id: match.id.toString(),
      homeTeam: match.home_team,
      awayTeam: match.away_team,
      matchDate: match.match_date,
      stadium: match.stadium,
      competition: match.competition,
      status: match.status,
      requirements: match.requirements,
      salePhases: match.sale_phases
    }));
  }

  async getMatchById(id) {
    const match = await matchRepository.getMatchById(id);
    
    if (!match) {
      throw new Error('Partido no encontrado');
    }

    const sectors = await matchRepository.getSectorsByMatchId(id);

    return {
      id: match.id.toString(),
      homeTeam: match.home_team,
      awayTeam: match.away_team,
      matchDate: match.match_date,
      stadium: match.stadium,
      competition: match.competition,
      status: match.status,
      requirements: match.requirements,
      salePhases: match.sale_phases,
      availableSectors: sectors.map(sector => ({
        id: sector.id.toString(),
        name: sector.name,
        price: parseFloat(sector.price),
        isAvailable: sector.is_available
      }))
    };
  }
}

module.exports = new MatchService();