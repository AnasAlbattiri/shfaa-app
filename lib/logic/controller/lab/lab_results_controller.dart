import 'package:get/get.dart';
import '../../../data/model/lab_results_model.dart';
import '../../../data/web_services/lab_results_service.dart';

class LaboratoryResultsController extends GetxController {
  var isLoading = false.obs;
  var labResults = <LaboratoryResultsModel>[].obs;
  int activeIndex = 0;

  LaboratoryResultsController(int orderId, orderDtlId, testCat, resultType, profileId, siteId) {
    fetchLaboratoryResults(orderId, orderDtlId, testCat, resultType, profileId, siteId);
  }


  void fetchLaboratoryResults(int orderId, orderDtlId, testCat, resultType, profileId, siteId) async {
    isLoading(true);
    try {
      var fetchLaboratoryResults = await LaboratoryResultsService.fetchLaboratoryResults(orderId, orderDtlId, testCat, resultType, profileId, siteId);
      if (fetchLaboratoryResults != null && fetchLaboratoryResults.isNotEmpty) {
        labResults.value = fetchLaboratoryResults;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load results $e');
    } finally {
      isLoading(false);
    }
  }

}
