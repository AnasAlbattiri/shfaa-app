import 'package:get/get.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../data/model/laboratory_model.dart';

class LaboratoryController extends GetxController {
  var isLoading = false.obs;
  var laboratories = <LaboratoryModel>[].obs;
  int activeIndex = 0;

  LaboratoryController(int encounterId, printFlag) {
    fetchLaboratory(encounterId, printFlag);
  }


  void fetchLaboratory(int encounterId, printFlag) async {
    isLoading(true);
    try {
      var fetchLaboratory = await LaboratoryService.fetchLaboratory(encounterId, printFlag);
      if (fetchLaboratory != null && fetchLaboratory.isNotEmpty) {
        laboratories.value = fetchLaboratory;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load laboratories $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int encounterId) {
    if (activeIndex == 0) {
      fetchLaboratory(encounterId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchLaboratory(encounterId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    laboratories.clear();
  }

  void clearPendingData() {
    laboratories.clear();
  }
}
