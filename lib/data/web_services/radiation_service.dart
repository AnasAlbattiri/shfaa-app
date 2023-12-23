import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/radiation_model.dart';

class RadiationService {
  static Future<List<RadiationModel>> fetchRadiation(int encounterId, activeFlag) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryRadOrderForPat?encounterId=$encounterId&lang&activeFlag=$activeFlag');

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

        List<RadiationModel> rays = body.map(
              (dynamic item) => RadiationModel.fromJson(item),
        ).toList();

        return rays;
      }
      else {
        throw Exception('Failed to load radiation');
      }
    } catch (e) {
      throw Exception('Failed to load radiation: $e');
    }
  }
}
