import 'package:get/get.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../../data/model/all_labs_model.dart';
import '../../../data/model/laboratory_model.dart';
import '../../../data/web_services/all_labs_service.dart';

class AllLabsController extends GetxController {
  var isLoading = false.obs;
  var allLabs = <AllLabsModel>[].obs;
  int activeIndex = 0;

  AllLabsController(int patientId, printFlag) {
    fetchAllLabs(patientId, printFlag);
  }


  void fetchAllLabs(int patientId, printFlag) async {
    isLoading(true);
    try {
      var fetchAllLabs = await AllLabsService.fetchAllLabs(patientId, printFlag);
      if (fetchAllLabs != null && fetchAllLabs.isNotEmpty) {
        allLabs.value = fetchAllLabs;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load all labs $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int patientId) {
    if (activeIndex == 0) {
      fetchAllLabs(patientId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchAllLabs(patientId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    allLabs.clear();
  }

  void clearPendingData() {
    allLabs.clear();
  }

}
