import 'package:get/get.dart';
import 'package:patient_app/data/model/visits_model.dart';
import 'package:patient_app/data/web_services/visits_service.dart';

class VisitsController extends GetxController {
  var isLoading = false.obs;
  var visits = <VisitsModel>[].obs;

  VisitsController(int patientId) {
    fetchVisits(patientId);
  }


  void fetchVisits(int patientId) async {
    isLoading(true);
    try {
      var fetchVisits = await VisitsService.fetchVisits(patientId);
      if (fetchVisits != null && fetchVisits.isNotEmpty) {
        visits.value = fetchVisits;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load visits $e');
    } finally {
      isLoading(false);
    }
  }
}
