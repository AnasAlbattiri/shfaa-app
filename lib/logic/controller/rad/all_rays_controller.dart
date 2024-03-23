import 'package:get/get.dart';
import '../../../data/model/all_rays_model.dart';
import '../../../data/web_services/all_rays_service.dart';

class AllRaysController extends GetxController {
  var isLoading = false.obs;
  var allRays = <AllRaysModel>[].obs;
  int activeIndex = 0;

  AllRaysController(int patientId, printFlag) {
    fetchAllRays(patientId, printFlag);
  }


  void fetchAllRays(int patientId, printFlag) async {
    isLoading(true);
    try {
      var fetchAllRays = await AllRaysService.fetchAllRays(patientId, printFlag);
      if (fetchAllRays != null && fetchAllRays.isNotEmpty) {
        allRays.value = fetchAllRays;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load all rays $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int patientId) {
    if (activeIndex == 0) {
      fetchAllRays(patientId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchAllRays(patientId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    allRays.clear();
  }

  void clearPendingData() {
    allRays.clear();
  }

}
