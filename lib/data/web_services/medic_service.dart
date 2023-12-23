import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/medicine_model.dart';

import '../../utils/constants.dart';

class MedicService {
  static Future<List<MedicineModel>> fetchMedic(int patientId) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryMedChrPhrForPat?patientId=$patientId&lang');

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

        List<MedicineModel> medics = body.map(
              (dynamic item) => MedicineModel.fromJson(item),
        ).toList();

        return medics;
      }
      else {
        throw Exception('Failed to load medics');
      }
    } catch (e) {
      throw Exception('Failed to load medics: $e');
    }
  }
}
