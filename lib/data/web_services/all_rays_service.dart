import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/all_rays_model.dart';

class AllRaysService {
  static Future<List<AllRaysModel>> fetchAllRays(int patientId, printFlag) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryAllRadOrderForPat?patientId=$patientId&lang&activeFlag=$printFlag');

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

        List<AllRaysModel> allRays = body.map(
              (dynamic item) => AllRaysModel.fromJson(item),
        ).toList();

        return allRays;
      }
      else {
        throw Exception('Failed to load all rays');
      }
    } catch (e) {
      throw Exception('Failed to load all rays: $e');
    }
  }
}
