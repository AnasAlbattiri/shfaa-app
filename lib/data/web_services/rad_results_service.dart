import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/rad_results_model.dart';
import '../model/readnotf_model.dart';

class RadResultsService {
  static Future<List<RadResultsModel>> fetchRadResults(int orderDtl, siteId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryRadOrderResult?orderDtl=10617&siteId=1');

    try {
      // Make the HTTP request
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<RadResultsModel> radResults = body.map(
              (dynamic item) => RadResultsModel.fromJson(item),
        ).toList();

        return radResults;
      }
      else {
        throw Exception('Failed to load rad results');
      }
    } catch (e) {
      throw Exception('Failed to load rad results: $e');
    }
  }
}
