import 'package:get/get.dart';
import 'package:patient_app/data/web_services/radiation_service.dart';
import '../../data/model/radiation_model.dart';

class RadiationController extends GetxController {
  var isLoading = false.obs;
  var rays = <RadiationModel>[].obs;
  int activeIndex = 0;

  RadiationController(int encounterId, activeFlag) {
    fetchRadiation(encounterId, activeFlag);
  }


  void fetchRadiation(int encounterId, activeFlag) async {
    isLoading(true);
    try {
      var fetchRadiation = await RadiationService.fetchRadiation(encounterId, activeFlag);
      if (fetchRadiation != null && fetchRadiation.isNotEmpty) {
        rays.value = fetchRadiation;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load rays $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int encounterId) {
    if (activeIndex == 0) {
      fetchRadiation(encounterId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchRadiation(encounterId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    rays.clear();
  }

  void clearPendingData() {
    rays.clear();
  }

}
