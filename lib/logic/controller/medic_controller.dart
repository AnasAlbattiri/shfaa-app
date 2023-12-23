import 'package:get/get.dart';
import '../../data/model/medicine_model.dart';
import '../../data/web_services/medic_service.dart';

class MedicController extends GetxController {
  var isLoading = false.obs;
  var medics = <MedicineModel>[].obs;

  MedicController(int patientId) {
    fetchMedic(patientId);
  }


  void fetchMedic(int patientId) async {
    isLoading(true);
    try {
      var fetchMedic = await MedicService.fetchMedic(patientId);
      if (fetchMedic != null && fetchMedic.isNotEmpty) {
        medics.value = fetchMedic;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load medicines $e');
    } finally {
      isLoading(false);
    }
  }
}
