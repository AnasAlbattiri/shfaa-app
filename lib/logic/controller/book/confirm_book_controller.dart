import 'package:get/get.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../../data/model/laboratory_model.dart';

class ConfirmBookController extends GetxController {
  var isLoading = false.obs;
  var laboratories = <LaboratoryModel>[].obs;

  ConfirmBookController(int encounterId, printFlag) {
    fetchConfirmBook(encounterId, printFlag);
  }


  void fetchConfirmBook(int encounterId, printFlag) async {
    isLoading(true);
    try {
      var fetchLaboratory = await LaboratoryService.fetchLaboratory(encounterId,printFlag);
      if (fetchLaboratory != null && fetchLaboratory.isNotEmpty) {
        laboratories.value = fetchLaboratory;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load confirm book $e');
    } finally {
      isLoading(false);
    }
  }
}
