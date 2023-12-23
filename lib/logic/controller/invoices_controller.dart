import 'package:get/get.dart';
import '../../data/model/invoices_model.dart';
import '../../data/web_services/invoice_service.dart';

class InvoicesController extends GetxController {
  var isLoading = false.obs;
  var invoices = <InvoicesModel>[].obs;

  InvoicesController(int patientId) {
    fetchInvoices(patientId);
  }


  void fetchInvoices(int patientId) async {
    isLoading(true);
    try {
      var fetchedInvoices = await InvoiceService.fetchInvoices(patientId);
      if (fetchedInvoices != null && fetchedInvoices.isNotEmpty) {
        invoices.value = fetchedInvoices;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load invoices');
    } finally {
      isLoading(false);
    }
  }
}
