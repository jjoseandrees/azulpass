import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';

class AuthRemoteDataSource {
  final http.Client client;
  String? _token;

  AuthRemoteDataSource({required this.client});

  String? get token => _token;

  Future<Map<String, dynamic>> login(String rut) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/auth/login');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode({'rut': rut}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      _token = data['data']['token'];
      return data['data'];
    } else {
      final errorData = json.decode(utf8.decode(response.bodyBytes));
      throw Exception(errorData['error'] ?? 'Error al iniciar sesión');
    }
  }

  Future<List<Map<String, dynamic>>> getMyTickets() async {
    if (_token == null) {
      throw Exception('No hay token de autenticación');
    }

    final url = Uri.parse('${ApiConstants.baseUrl}/tickets/my-tickets');

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Error al cargar las entradas');
    }
  }
}