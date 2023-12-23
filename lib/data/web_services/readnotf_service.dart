import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/insurance_model.dart';
import 'package:patient_app/data/model/unreadnotf_model.dart';
import '../../utils/constants.dart';
import '../model/laboratory_model.dart';
import '../model/readnotf_model.dart';

class ReadNotfService {
  static Future<List<ReadNotfModel>> fetchReadNotf(int patientId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryNotificationsRead?patientId=$patientId&lang');

    try {
      // Make the HTTP request
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<ReadNotfModel> readNotifis = body.map(
              (dynamic item) => ReadNotfModel.fromJson(item),
        ).toList();

        return readNotifis;
      }
      else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }
}
