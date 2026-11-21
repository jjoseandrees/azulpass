import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';

class MatchRemoteDataSource {
  final http.Client client;

  MatchRemoteDataSource({required this.client});

  Future<List<Map<String, dynamic>>> getUpcomingMatches() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.matches}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Error al cargar partidos: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getMatchById(String id) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.matches}/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Map<String, dynamic>.from(data['data']);
    } else if (response.statusCode == 404) {
      throw Exception('Partido no encontrado');
    } else {
      throw Exception('Error al cargar partido: ${response.statusCode}');
    }
  }
}