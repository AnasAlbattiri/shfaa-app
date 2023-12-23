import 'package:get/get.dart';
import 'package:patient_app/data/model/insurance_model.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../data/model/laboratory_model.dart';
import '../../data/web_services/insurance_service.dart';

class InsuranceController extends GetxController {
  var isLoading = false.obs;
  var insurances = <InsuranceModel>[].obs;

  InsuranceController(int siteId) {
    fetchInsurance(siteId);
  }


  void fetchInsurance(int siteId) async {
    isLoading(true);
    try {
      var fetchInsurance = await InsuranceService.fetchInsurance(siteId);
      if (fetchInsurance != null && fetchInsurance.isNotEmpty) {
        insurances.value = fetchInsurance;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load insurance companies $e');
    } finally {
      isLoading(false);
    }
  }
}
