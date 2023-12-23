import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/all_appointments_model.dart';

import '../../utils/constants.dart';

class AllAppointmentsService {
  static Future<List<AllAppointmentModel>> fetchAllAppointments(int clinicId, siteId, doctorId, DateTime apptDate) async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryTimeResorseDiary?siteId=$siteId&clinicId=$clinicId&doctorId=$doctorId&AppDate=$apptDate');

    try {
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<AllAppointmentModel> allAppointments = body.map(
              (dynamic item) => AllAppointmentModel.fromJson(item),
        ).toList();

        return allAppointments;
      }
      else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }
}
