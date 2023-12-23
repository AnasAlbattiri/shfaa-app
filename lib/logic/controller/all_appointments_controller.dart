import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:patient_app/data/model/all_appointments_model.dart';
import 'package:patient_app/logic/controller/upcoming_controller.dart';
import '../../data/model/upcoming_appoint_model.dart';
import '../../utils/constants.dart';

class AllAppointmentsController extends GetxController {
  var isLoading = false.obs;
  var allAppointments = <AllAppointmentModel>[].obs;
  DateTime selectedDate = DateTime.now();
  bool chechConf = false;


  Future<void> confirmAppointment(
      String siteId, patId, patName, apptId) async {
    var response = await http.get(
      Uri.parse(
          "http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/confirmAppoinmtentGet?siteId=$siteId&patientId=$patId&patientNameLog=$patName&appointmentId=$apptId"),
      headers: {
        HttpHeaders.acceptCharsetHeader: "utf8",
        HttpHeaders.contentTypeHeader: 'application/json'
      },
    );

    if (response.statusCode == 200) {
      // Get an instance of UpcomingController and refresh upcomings
      final UpcomingController upcomingController = Get.find();
      upcomingController.fetchUpcoming(patId);
    }
  }


  Future<List<AllAppointmentModel>> getTimeAppResource(
      String siteId, clinicId, doctorId, apptDate) async {
    var data = await http.get(
        Uri.parse(
            "http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryTimeResorseDiary?siteId=$siteId&clinicId=$clinicId&doctorId=$doctorId&AppDate=$apptDate"),
        headers: {
          HttpHeaders.acceptCharsetHeader: "utf8",
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    var jsonData = json.decode(utf8.decode(data.bodyBytes));

    List<AllAppointmentModel> resAppt = [];
    for (var p in jsonData) {
      AllAppointmentModel timeRes = AllAppointmentModel(
          apptId: p['apptId'],
          superResRefTransId: p['superResRefTransId'],
          resourceDate: p['resourceDate'],
          startTime: p['startTime'],
          siteId: p['siteId'],
      );
      resAppt.add(timeRes);
    }
    return resAppt;
  }

  // This method now returns a bool indicating if an appointment exists
  Future<bool> getValidationConfAppt(int patId, String docId, clinicId, siteId) async {
    var response = await http.get(
        Uri.parse("http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/queryValidationConfermAppt?patientId=$patId&docId=$docId&clinicId=$clinicId&siteId=$siteId"),
        headers: {
          HttpHeaders.acceptCharsetHeader: "utf8",
          HttpHeaders.contentTypeHeader: 'application/json'
        });

    var jsonData = json.decode(utf8.decode(response.bodyBytes));
    chechConf = jsonData.isNotEmpty;
    return chechConf;
  }


  void removeConfirmedAppointment(int apptId) {
    allAppointments.removeWhere((appointment) => appointment.apptId == apptId);
  }

  Future<void> cancelAppointment(int apptId, int siteId, int patientId) async {

    var cancelUrl = 'http://${AppConstants.serverIP}/SIQMobileAPI/resources/model/cancelAppointments?apptId=$apptId&siteId=$siteId&sysUser=$patientId';

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
        print("Appointment Removed Successfully!");
        print(response.body);
      } else {
        print("Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (error) {
      print("Exception: $error");
    }
  }



}

