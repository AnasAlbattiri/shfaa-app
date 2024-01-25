import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/lab_group_model.dart';
import '../model/lab_results_model.dart';

class LabGroupService {
  static Future<List<LabGroupModel>> fetchLabGroup(int orderDtlId, testId, siteId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryLabGroupTestResultFindbyOrderIdTestId?sysOrderDtl=$orderDtlId&labTestId=$testId&siteId=$siteId&lang');

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

        List<LabGroupModel> labResults = body.map(
              (dynamic item) => LabGroupModel.fromJson(item),
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
