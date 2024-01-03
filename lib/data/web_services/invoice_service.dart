import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/invoices_model.dart';

class InvoiceService {
  static Future<List<InvoicesModel>> fetchInvoices(int patientId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryAllInvoices?patientId=$patientId');

    try {
      // Make the HTTP request
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      // Check if the request was successful
      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<InvoicesModel> invoices = body.map(
              (dynamic item) => InvoicesModel.fromJson(item),
        ).toList();

        return invoices;
      }
      else {
        throw Exception('Failed to load invoices: $response');
      }
    } catch (e) {
      throw Exception('Failed to load invoices: $e');
    }
  }
}
