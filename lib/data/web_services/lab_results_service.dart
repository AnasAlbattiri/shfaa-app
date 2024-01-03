import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/lab_results_model.dart';
import '../model/laboratory_model.dart';

class LaboratoryResultsService {
  static Future<List<LaboratoryResultsModel>> fetchLaboratoryResults(int orderId, orderDtlId, testCat, resultType, profileId, siteId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryLabResult?orderId=$orderId&orderDtlId=$orderDtlId&testCat=$testCat&resultType=$resultType&profileId=$profileId&siteId=$siteId&lang');

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

        List<LaboratoryResultsModel> labResults = body.map(
              (dynamic item) => LaboratoryResultsModel.fromJson(item),
        ).toList();

        return labResults;
      }
      else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      throw Exception('Failed to load results: $e');
    }
  }
}
