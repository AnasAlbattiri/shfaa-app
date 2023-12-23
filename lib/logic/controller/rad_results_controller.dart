import 'package:get/get.dart';
import 'package:patient_app/data/model/insurance_model.dart';
import 'package:patient_app/data/model/rad_results_model.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../data/model/laboratory_model.dart';
import '../../data/model/readnotf_model.dart';
import '../../data/model/unreadnotf_model.dart';
import '../../data/web_services/insurance_service.dart';
import '../../data/web_services/rad_results_service.dart';
import '../../data/web_services/readnotf_service.dart';
import '../../data/web_services/unreadnotf_service.dart';

class RadResultsController extends GetxController {
  var isLoading = false.obs;
  var radResults = <RadResultsModel>[].obs;

  RadResultsController(int orderDtl, siteId) {
    fetchRadResults(orderDtl, siteId);
  }


  void fetchRadResults(int orderDtl, siteId) async {
    isLoading(true);
    try {
      var fetchRadResults = await RadResultsService.fetchRadResults(orderDtl, siteId);
      if (fetchRadResults != null && fetchRadResults.isNotEmpty) {
        radResults.value = fetchRadResults;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load rad Results $e');
    } finally {
      isLoading(false);
    }
  }
}
