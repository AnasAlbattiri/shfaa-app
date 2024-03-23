import 'package:get/get.dart';
import '../../../data/model/lab_group_model.dart';
import '../../../data/web_services/lab_group_service.dart';

class LabGroupController extends GetxController {
  var isLoading = false.obs;
  var labGroup = <LabGroupModel>[].obs;
  int activeIndex = 0;

  LaboratoryResultsController(orderDtlId, testId, siteId) {
    fetchLabGroup(orderDtlId, testId, siteId);
  }


  void fetchLabGroup(int orderDtlId, testId, siteId) async {
    isLoading(true);
    try {
      var fetchLabGroup = await LabGroupService.fetchLabGroup(orderDtlId, testId, siteId);
      if (fetchLabGroup != null && fetchLabGroup.isNotEmpty) {
        labGroup.value = fetchLabGroup;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load results $e');
    } finally {
      isLoading(false);
    }
  }

}
