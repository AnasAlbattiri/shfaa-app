import 'package:get/get.dart';
import 'package:patient_app/data/web_services/normal_range_service.dart';
import '../../data/model/normal_range_model.dart';

class NormalRangeController extends GetxController {
  var isLoading = false.obs;
  var normalRanges = <NormalRangeModel>[].obs;
  int activeIndex = 0;

  NormalRangeController(testId, machinId, kitValue, genderType, siteId) {
    fetchNormalRanges(testId, machinId, kitValue, genderType, siteId);
  }

  void fetchNormalRanges(int testId, machinId, kitValue, genderType, siteId) async {
    isLoading(true);
    try {
      var fetchNormalRanges = await NormalRangeService.fetchNormalRanges(testId, machinId, kitValue, genderType, siteId);
      if (fetchNormalRanges != null && fetchNormalRanges.isNotEmpty) {
        normalRanges.value = fetchNormalRanges;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load normal ranges $e');
    } finally {
      isLoading(false);
    }
  }
}
