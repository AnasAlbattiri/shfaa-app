import 'dart:convert';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

class UpdateNotfController extends GetxController {

  Future<void> updateNotification(int sysNotiId, int patientId) async {
    var cancelUrl = 'http://${AppConstants
        .serverIP}/SIQMobileAPI/resources/model/updateReadNotifications?&sysNotiId=$sysNotiId&sysUser=$patientId';

    final Map<String, dynamic> requestBody = {
    };


    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(cancelUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Updated successfully!");
        print(response.body);
        update();
      } else {
        print("Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (error) {
      print("Exception: $error");
    }
  }

}
