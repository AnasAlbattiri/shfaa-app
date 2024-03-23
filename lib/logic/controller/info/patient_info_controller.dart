import 'package:get/get.dart';
import 'package:patient_app/data/model/patient_info_model.dart';
import '../../../data/model/invoices_model.dart';
import '../../../data/web_services/invoice_service.dart';
import '../../../data/web_services/patient_info_service.dart';

class PatientInfoController extends GetxController {
  var isLoading = false.obs;
  var patInfo = <PatientInfoModel>[].obs;

  PatientInfoController(int patientId) {
    fetchPatientInfo(patientId);
  }


  void fetchPatientInfo(int patientId) async {
    isLoading(true);
    try {
      var fetchPatientInfo = await PatientInfoService.fetchPatientInfo(patientId);
      if (fetchPatientInfo != null && fetchPatientInfo.isNotEmpty) {
        patInfo.value = fetchPatientInfo;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load patInfo');
    } finally {
      isLoading(false);
    }
  }
}
