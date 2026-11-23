import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../models/ticket_model.dart';

class TicketRemoteDataSource {
  final http.Client client;

  TicketRemoteDataSource({required this.client});

  Future<TicketModel> purchaseTicket({
    required int matchId,
    required int sectorId,
    required int quantity,
    required String buyerRut,
    required String buyerName,
    required String buyerEmail,
    required String buyerPhone,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tickets}/purchase');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'}, // UTF-8 para las tildes
      body: jsonEncode({
        'matchId': matchId,
        'sectorId': sectorId,
        'quantity': quantity,
        'buyerRut': buyerRut,
        'buyerName': buyerName,
        'buyerEmail': buyerEmail,
        'buyerPhone': buyerPhone,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return TicketModel.fromJson(data['data']);
    } else {
      final errorData = json.decode(utf8.decode(response.bodyBytes));
      throw Exception(errorData['error'] ?? 'Error al procesar la compra');
    }
  }

  //  Obtener entradas por RUT
  Future<List<TicketModel>> getUserTickets(String rut) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tickets}/$rut');

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> ticketsJson = data['data'];
      return ticketsJson.map((json) => TicketModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las entradas: ${response.statusCode}');
    }
  }
}

