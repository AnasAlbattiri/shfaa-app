import 'package:get/get.dart';
import 'package:patient_app/data/model/pharmacy_model.dart';
import '../../../data/web_services/all_pharmacy_service.dart';


class AllPharmacyController extends GetxController {
  var isLoading = false.obs;
  var pharmacy = <PharmacyModel>[].obs;
  int activeIndex = 0;

  AllPharmacyController(int patientId, activeFlag) {
    fetchAllPharmacy(patientId, activeFlag);
  }


  void fetchAllPharmacy(int patientId, activeFlag) async {
    isLoading(true);
    try {
      var fetchAllPharmacy = await AllPharmacyService.fetchAllPharmacy(patientId, activeFlag);
      if (fetchAllPharmacy != null && fetchAllPharmacy.isNotEmpty) {
        pharmacy.value = fetchAllPharmacy;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load pharmacy $e');
    } finally {
      isLoading(false);
    }
  }

  void updatePrintFlag(int patientId) {
    if (activeIndex == 0) {
      fetchAllPharmacy(patientId, 1);
      clearPendingData();
    } else if (activeIndex == 1) {
      fetchAllPharmacy(patientId, 2);
      clearActiveData();
    }
  }

  void clearActiveData() {
    pharmacy.clear();
  }

  void clearPendingData() {
    pharmacy.clear();
  }

}
