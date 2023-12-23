import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/upcoming_model.dart';

import '../../utils/constants.dart';

class UpcomingService {
  static Future<List<UpcomingModel>> fetchUpcoming(int patientId) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryUpCommingApptList?patientId=$patientId');

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

        List<UpcomingModel> upcomings = body.map(
              (dynamic item) => UpcomingModel.fromJson(item),
        ).toList();

        return upcomings;
      }
      else {
        throw Exception('Failed to load upcomings');
      }
    } catch (e) {
      throw Exception('Failed to load upcomings');
    }
  }
}
