import 'package:get/get.dart';
import 'package:patient_app/data/model/pharmacy_model.dart';
import 'package:patient_app/data/web_services/pharmacy_service.dart';
import '../../../data/model/radiation_model.dart';

class PharmacyController extends GetxController {
  var isLoading = false.obs;
  var pharmacies = <PharmacyModel>[].obs;
  int activeIndex = 0;

  PharmacyController(int encounterId, activeFlag) {
    fetchPharmacy(encounterId, activeFlag);
  }


  void fetchPharmacy(int encounterId, activeFlag) async {
    isLoading(true);
    try {
      var fetchPharmacy = await PharmacyService.fetchPharmacy(encounterId, activeFlag);
      if (fetchPharmacy != null && fetchPharmacy.isNotEmpty) {
        pharmacies.value = fetchPharmacy;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load pharmacy $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int encounterId) {
    if (activeIndex == 0) {
      fetchPharmacy(encounterId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchPharmacy(encounterId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    pharmacies.clear();
  }

  void clearPendingData() {
    pharmacies.clear();
  }
}
