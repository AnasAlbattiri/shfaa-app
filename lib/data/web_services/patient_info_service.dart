import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/invoices_model.dart';
import '../model/patient_info_model.dart';

class PatientInfoService {
  static Future<List<PatientInfoModel>> fetchPatientInfo(int patientId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/querySysPatientInfo?patientId=$patientId');

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

        List<PatientInfoModel> patInfo = body.map(
              (dynamic item) => PatientInfoModel.fromJson(item),
        ).toList();

        return patInfo;
      }
      else {
        throw Exception('Failed to load patInfo');
      }
    } catch (e) {
      throw Exception('Failed to load patInfo: $e');
    }
  }
}
