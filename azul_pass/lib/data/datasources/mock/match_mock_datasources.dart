/// Simula la respuesta cruda de tu API (JSON).
/// En el futuro, esto será reemplazado por un `RemoteDataSource` 
/// que haga peticiones HTTP (con Dio o http).
class MatchMockDataSource {
  Future<List<Map<String, dynamic>>> getUpcomingMatches() async {
    // Simulamos un delay de red (1 segundo)
    await Future.delayed(const Duration(seconds: 1));

    return [
      {
        "id": "1",
        "homeTeam": "Universidad de Chile",
        "awayTeam": "Everton de Viña del Mar",
        "matchDate": "2026-10-26T20:00:00Z",
        "stadium": "Estadio Nacional",
        "competition": "Primera División",
        "status": "upcoming"
      },
      {
        "id": "2",
        "homeTeam": "Universidad Católica",
        "awayTeam": "Universidad de Chile",
        "matchDate": "2026-11-01T17:15:00Z",
        "stadium": "Claro Arena",
        "competition": "Primera División",
        "status": "upcoming"
      }
    ];
  }
}