import 'package:get/get.dart';
import 'package:patient_app/data/web_services/upcoming_service.dart';
import '../../../data/model/upcoming_model.dart';

class UpcomingController extends GetxController {
  var isLoading = false.obs;
  var upcomings = <UpcomingModel>[].obs;

  UpcomingController(int patientId) {
    fetchUpcoming(patientId);
  }


  void fetchUpcoming(int patientId) async {
    isLoading(true);
    try {
      var fetchUpcoming = await UpcomingService.fetchUpcoming(patientId);
      if (fetchUpcoming != null && fetchUpcoming.isNotEmpty) {
        upcomings.value = fetchUpcoming;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load upcomings: $e');
    } finally {
      isLoading(false);
    }
  }

  void removeAppointment(int apptNo) {
    upcomings.removeWhere((upcomingAppoint) => upcomingAppoint.apptNo == apptNo);
  }
}
