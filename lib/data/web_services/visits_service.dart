import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/visits_model.dart';

import '../../utils/constants.dart';

class VisitsService {
  static Future<List<VisitsModel>> fetchVisits(int patientId) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryAllVisitForPatient?patientId=$patientId&lang');

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

        List<VisitsModel> visits = body.map(
              (dynamic item) => VisitsModel.fromJson(item),
        ).toList();

        return visits;
      }
      else {
        throw Exception('Failed to load visits');
      }
    } catch (e) {
      throw Exception('Failed to load visits: $e');
    }
  }
}
