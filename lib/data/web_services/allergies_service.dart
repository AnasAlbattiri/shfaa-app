import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/allergies_model.dart';

class AllergiesService {
  static Future<List<AllergiesModel>> fetchAllergies(int patientId) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryPatientAllergie?PatientId=$patientId&lang');

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

        List<AllergiesModel> allergies = body.map(
              (dynamic item) => AllergiesModel.fromJson(item),
        ).toList();

        return allergies;
      }
      else {
        throw Exception('Failed to load allergies');
      }
    } catch (e) {
      throw Exception('Failed to load allergies: $e');
    }
  }
}
