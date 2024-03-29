import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/constants.dart';

class AuthController extends GetxController {

  // Login
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisibility = false;




  void visibility() {
    isVisibility = !isVisibility;
    update();
  }

  Future<void> patientSignIn(String userName, String userPassword) async {
    try {
      var response = await http.get(
        Uri.parse(
            "http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/getUserPortal?userName=$userName&passowrd=$userPassword"),
      );

      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (jsonResponse != null) {
        if (jsonResponse['result'] == 'msgPass') {
          var userId = jsonResponse['userId'];
          var userName = jsonResponse['userName'];
          var patientId = jsonResponse['patientId'];
          Get.offNamed('/main', arguments: {
            'userId': userId,
            'userName': userName,
            'patientId': patientId,
          },
          );
          print("Response: $jsonResponse['result'] ");
          update();

        } else if (jsonResponse['result'] == 'msgFail') {
          Get.snackbar("Error", "Invalid username/password. Please enter the correct username/password.", snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar("Error", "Invalid username/password. Please enter the correct username/password.", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signOut() async {
  }


}
