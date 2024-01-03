import 'package:get/get.dart';
import 'package:patient_app/data/model/insurance_model.dart';
import 'package:patient_app/data/web_services/laboratory_service.dart';
import '../../data/model/laboratory_model.dart';
import '../../data/model/unreadnotf_model.dart';
import '../../data/web_services/insurance_service.dart';
import '../../data/web_services/unreadnotf_service.dart';
import '../../utils/local_notifications.dart';

class UnReadNotfController extends GetxController {
  var isLoading = false.obs;
  var unNotifs = <UnReadNotfModel>[].obs;

  UnReadNotfController(int patientId) {
    fetchUnReadNotf(patientId);
  }


  void fetchUnReadNotf(int patientId) async {
    isLoading(true);
    try {
      var fetchUnReadNotf = await UnReadNotfService.fetchUnReadNotf(patientId);
      if (fetchUnReadNotf != null && fetchUnReadNotf.isNotEmpty) {
        unNotifs.value = fetchUnReadNotf;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications $e');
    } finally {
      isLoading(false);
    }
  }

  void addNotification(UnReadNotfModel newNotification) {
    unNotifs.add(newNotification);
    LocalNotifications.showDefaultNotification(
      title: 'Shfaa Notification',
      body: 'Your health is our first priority',
      payload: 'This is Data',
    );
  }


  void removeClickedNotification(int id) {
    unNotifs.removeWhere((notification) => notification.id == id);
  }
}
