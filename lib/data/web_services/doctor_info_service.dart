import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/doctor_info_model.dart';


class DoctorInfoService {

  static Future<List<DoctorInfoModel>> fetchDoctorInfo() async {
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryEmployeeDoctorsAppt');

    try {
      // Make the HTTP request
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<DoctorInfoModel> docInfo = body.map(
              (dynamic item) => DoctorInfoModel.fromJson(item),
        ).toList();
        return docInfo;
      }
      else {
        throw Exception('Failed to load docInfo');
      }
    } catch (e) {
      throw Exception('Failed to load docInfo: $e');
    }
  }
}
