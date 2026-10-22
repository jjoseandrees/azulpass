class MatchMockDataSource {
  Future<List<Map<String, dynamic>>> getUpcomingMatches() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockMatches;
  }

  // Simula buscar un partido por su ID
  Future<Map<String, dynamic>?> getMatchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockMatches.firstWhere((match) => match['id'] == id);
    } catch (e) {
      return null;
    }
  }

  final List<Map<String, dynamic>> _mockMatches = [
    {
      "id": "1",
      "homeTeam": "Universidad de Chile",
      "awayTeam": "Everton de Viña del Mar",
      "matchDate": "2026-10-26T19:00:00Z",
      "stadium": "Estadio Nacional",
      "competition": "Primera División",
      "status": "upcoming",
      "requirements": [
        "Registro Nacional de Hinchas obligatorio",
        "Cédula de identidad con chip legible"
      ],
      "salePhases": [
        "Preventa Socios: 20/10 10:00 hrs",
        "Venta General: 22/10 10:00 hrs"
      ],
      "sectors": [
        {"id": "s1", "name": "Galería Andes", "price": 15000, "isAvailable": true},
        {"id": "s2", "name": "Galería Pacífico", "price": 15000, "isAvailable": true},
        {"id": "s3", "name": "Preferencia", "price": 25000, "isAvailable": true},
        {"id": "s4", "name": "Tribuna", "price": 35000, "isAvailable": false} // Agotado
      ]
    },
    {
      "id": "2",
      "homeTeam": "Universidad Católica",
      "awayTeam": "Universidad de Chile",
      "matchDate": "2026-11-01T20:00:00Z",
      "stadium": "Claro Arena",
      "competition": "Primera División",
      "status": "upcoming",
      "requirements": ["Registro Nacional de Hinchas obligatorio"],
      "salePhases": ["Venta General: 25/10 10:00 hrs"],
      "sectors": [
        {"id": "s5", "name": "Visita - Galería", "price": 18000, "isAvailable": true}
      ]
    }
  ];
}