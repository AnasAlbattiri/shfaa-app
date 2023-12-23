import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:patient_app/data/model/insurance_model.dart';
import '../../utils/constants.dart';
import '../model/laboratory_model.dart';

class InsuranceService {
  static Future<List<InsuranceModel>> fetchInsurance(int sitId) async {
    // URL of the API endpoint
    var url = Uri.parse(
        'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryAllInsuranceCompany?siteId=$sitId&lang');

    try {
      // Make the HTTP request
      var response = await http.get(url, headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      });

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedResponse);

        List<InsuranceModel> insurance = body.map(
              (dynamic item) => InsuranceModel.fromJson(item),
        ).toList();

        return insurance;
      }
      else {
        throw Exception('Failed to load insurance companies');
      }
    } catch (e) {
      throw Exception('Failed to load confirm book: $e');
    }
  }
}
