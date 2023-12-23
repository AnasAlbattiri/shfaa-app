import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/visits_model.dart';
import 'package:patient_app/data/model/vitals_model.dart';

import '../../utils/constants.dart';

class VitalsService {
  static Future<List<VitalsModel>> fetchVitals(int patientId) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryVitalSignByPatients?patientId=$patientId&lang');

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

        List<VitalsModel> vitals = body.map(
              (dynamic item) => VitalsModel.fromJson(item),
        ).toList();

        return vitals;
      }
      else {
        throw Exception('Failed to load vitals');
      }
    } catch (e) {
      throw Exception('Failed to load vitals: $e');
    }
  }
}
