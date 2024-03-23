import 'package:get/get.dart';
import 'package:patient_app/data/model/insurance_model.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../../data/model/laboratory_model.dart';
import '../../../data/model/readnotf_model.dart';
import '../../../data/model/unreadnotf_model.dart';
import '../../../data/web_services/insurance_service.dart';
import '../../../data/web_services/readnotf_service.dart';
import '../../../data/web_services/unreadnotf_service.dart';

class ReadNotfController extends GetxController {
  var isLoading = false.obs;
  var readNotifs = <ReadNotfModel>[].obs;

  ReadNotfController(int patientId) {
    fetchReadNotf(patientId);
  }


  void fetchReadNotf(int patientId) async {
    isLoading(true);
    try {
      var fetchReadNotf = await ReadNotfService.fetchReadNotf(patientId);
      if (fetchReadNotf != null && fetchReadNotf.isNotEmpty) {
        readNotifs.value = fetchReadNotf;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications $e');
    } finally {
      isLoading(false);
    }
  }
}
