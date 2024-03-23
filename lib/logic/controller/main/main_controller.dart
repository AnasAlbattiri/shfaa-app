import 'package:get/get.dart';
import 'package:patient_app/view/screens/nav/medic_screen.dart';
import 'package:patient_app/view/screens/nav/invoices_screen.dart';
import 'package:patient_app/view/screens/nav/calender_screen.dart';
import '../../../view/screens/nav/home_screen.dart';
import '../../../view/screens/nav/profile_screen.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  final screens = [
    HomeScreen(),
    CalenderScreen(),
    InvoicesScreen(),
    MedicScreen(),
    ProfileScreen(),
  ].obs;

}