import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/normal_range_model.dart';
import '../../utils/constants.dart';

class NormalRangeService {
  static Future<List<NormalRangeModel>> fetchNormalRanges(int testId, machinId, kitValue, genderType, siteId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryLabNormalRangesFindByLabTestIdAndMachinAndKit?labTestId=$testId&machinId=$machinId&kitValue=$kitValue&genderType=$genderType&siteId=$siteId&lang');

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

        List<NormalRangeModel> normalRanges = body.map(
              (dynamic item) => NormalRangeModel.fromJson(item),
        ).toList();

        return normalRanges;
      }
      else {
        throw Exception('Failed to load normal ranges');
      }
    } catch (e) {
      throw Exception('Failed to load normal ranges: $e');
    }
  }
}
