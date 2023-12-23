import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/laboratory_model.dart';

class LaboratoryService {
  static Future<List<LaboratoryModel>> fetchLaboratory(int encounterId, printFlag) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryLabOrderForPat?encounterId=$encounterId&lang&printFlag=$printFlag');

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

        List<LaboratoryModel> laboratories = body.map(
              (dynamic item) => LaboratoryModel.fromJson(item),
        ).toList();

        return laboratories;
      }
      else {
        throw Exception('Failed to load laboratory');
      }
    } catch (e) {
      throw Exception('Failed to load laboratory: $e');
    }
  }
}
