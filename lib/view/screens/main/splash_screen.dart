import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../utils/constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Get.offNamed('/login'); // Map
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wColor,
      body: SizedBox(
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/SHefaa.jpg',),
              height: 400,
              width: 400,

            ),
            SpinKitThreeBounce(
              color: mainColor,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}