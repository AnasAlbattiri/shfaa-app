import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/pharmacy_model.dart';

class PharmacyService {
  static Future<List<PharmacyModel>> fetchPharmacy(int encounterId, activeFlag) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryPresecPhrOrderForPat?encounterId=$encounterId&lang&activeFlag=$activeFlag');

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

        List<PharmacyModel> pharmacies = body.map(
              (dynamic item) => PharmacyModel.fromJson(item),
        ).toList();

        return pharmacies;
      }
      else {
        throw Exception('Failed to load pharmacy');
      }
    } catch (e) {
      throw Exception('Failed to load pharmacy: $e');
    }
  }
}
