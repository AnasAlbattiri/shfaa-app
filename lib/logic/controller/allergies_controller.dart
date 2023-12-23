import 'package:get/get.dart';
import 'package:patient_app/data/web_services/allergies_service.dart';
import '../../data/model/allergies_model.dart';


class AllergiesController extends GetxController {
  var isLoading = false.obs;
  var allergies = <AllergiesModel>[].obs;

  AllergiesController(int patientId) {
    fetchAllergies(patientId);
  }


  void fetchAllergies(int patientId) async {
    isLoading(true);
    try {
      var fetchAllergies = await AllergiesService.fetchAllergies(patientId);
      if (fetchAllergies != null && fetchAllergies.isNotEmpty) {
        allergies.value = fetchAllergies;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load allergies $e');
    } finally {
      isLoading(false);
    }
  }
}
