const matchService = require('../services/matchService');

class MatchController {
  async getUpcomingMatches(req, res, next) {
    try {
      const matches = await matchService.getUpcomingMatches();
      res.json({
        success: true,
        data: matches,
        count: matches.length
      });
    } catch (error) {
      next(error);
    }
  }

  async getMatchById(req, res, next) {
    try {
      const { id } = req.params;
      
      // Validación de ID (previene inyección SQL)
      if (!/^\d+$/.test(id)) {
        return res.status(400).json({
          success: false,
          error: 'ID de partido inválido'
        });
      }

      const match = await matchService.getMatchById(parseInt(id));
      
      res.json({
        success: true,
        data: match
      });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = new MatchController();