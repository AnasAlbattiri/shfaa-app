import 'package:get/get.dart';
import 'package:patient_app/data/model/visits_model.dart';
import '../../data/web_services/vitals_service.dart';
import 'package:patient_app/data/model/vitals_model.dart';

class VitalsController extends GetxController {
  var isLoading = false.obs;
  var vitals = <VitalsModel>[].obs;

  VitalsController(int patientId) {
    fetchVitals(patientId);
  }


  void fetchVitals(int patientId) async {
    isLoading(true);
    try {
      var fetchVitals = await VitalsService.fetchVitals(patientId);
      if (fetchVitals != null && fetchVitals.isNotEmpty) {
        vitals.value = fetchVitals;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load vitals $e');
    } finally {
      isLoading(false);
    }
  }
}
