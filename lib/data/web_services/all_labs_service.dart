import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/all_labs_model.dart';
import '../model/laboratory_model.dart';

class AllLabsService {
  static Future<List<AllLabsModel>> fetchAllLabs(int patientId, printFlag) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryAllLabOrderForPat?patientId=$patientId&lang&printFlag=$printFlag');

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

        List<AllLabsModel> alllabs = body.map(
              (dynamic item) => AllLabsModel.fromJson(item),
        ).toList();

        return alllabs;
      }
      else {
        throw Exception('Failed to load all labs');
      }
    } catch (e) {
      throw Exception('Failed to load all labs: $e');
    }
  }
}
