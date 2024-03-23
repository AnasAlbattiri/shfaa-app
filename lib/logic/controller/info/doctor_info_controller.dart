import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/data/model/doctor_info_model.dart';
import 'package:patient_app/data/web_services/doctor_info_service.dart';

class DoctorInfoController extends GetxController {
  var isLoading = false.obs;
  var docInfo = <DoctorInfoModel>[].obs;
  var searchList = <DoctorInfoModel>[].obs;
  TextEditingController searchController = TextEditingController();

  DoctorInfoController() {
    fetchDoctorInfo();
  }

  Future<bool> fetchDoctorInfo() async {
    isLoading(true);
    try {
      var fetchDoctorInfo = await DoctorInfoService.fetchDoctorInfo();
      if (fetchDoctorInfo != null && fetchDoctorInfo.isNotEmpty) {
        docInfo.value = fetchDoctorInfo;
        return true; // Indicating success
      }
      return false; // Indicating failure or no data
    } catch (e, stackTrace) {
      print('Fetch DoctorInfo Error: $e');
      print('Stack Trace: $stackTrace');
      Get.snackbar('Error', 'Failed to load docInfo: $e', snackPosition: SnackPosition.BOTTOM);
      return false; // Indicating error
    } finally {
      isLoading(false);
    }
  }

  void addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();
    if (searchName.isEmpty) {
      searchList.value = docInfo.value;
    } else {
      searchList.value = docInfo
          .where((search) {
        var searchTitle = search.empNameArb!.toLowerCase();
        return searchTitle.contains(searchName);
      }).toList();
    }
    update();
  }

  void clearSearch() {
    searchController.clear();
    addSearchToList('');
  }
}
