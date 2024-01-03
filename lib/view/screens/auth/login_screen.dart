import 'package:flutter/material.dart';
import 'package:patient_app/view/screens/auth/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../logic/controller/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../widgets/auth/login_form.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatelessWidget {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/login_background1.jpeg",
            height: MediaQuery.of(context).size.height,
            // Now it takes 100% of our height
          ),
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: Image.asset(
              'assets/images/SHefaa.jpg',
              height: 300,
              width: 400,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding * 7.5),
                    SizedBox(height: 30,),
                    LoginForm(formKey: _formKey),
                    GetBuilder<AuthController>(builder: (_){
                      return SizedBox(
                        width: double.infinity,
                        height: 53,
                        child: ElevatedButton(
                          onPressed: () {
                            authController.patientSignIn(
                              authController.userNameController.text,
                              authController.passwordController.text,
                            );
                          },
                          child: Text("Sign In",style: TextStyle(fontFamily: 'Circular', fontSize: 16),),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyle(fontFamily: 'Circular'),),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
