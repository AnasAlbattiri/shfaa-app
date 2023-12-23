import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controller/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../widgets/auth/auth_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Forget Password',
            style: TextStyle(
              color: primaryColor.withOpacity(0.95),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'It seems like you forgot your password. If this is true, Enter your email below to send password reset link to your email.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/forget.png',
                    width: 300,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return AuthTextFormField(
                        obscureText: false,
                        controller: emailController,
                        textType: TextInputType.text,
                        validator: (value) {
                          if (value.toString().length < 8) {
                            return 'Email address is not correct';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icon(
                          Icons.mail,
                          size: 30,
                          color: primaryColor.withOpacity(0.95),
                        ),
                        hintText: 'Email Address',
                        suffixIcon: Icon(
                          Icons.add,
                          color: Colors.transparent,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GetBuilder<AuthController>(builder: (_) {
                    return ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400, 50),
                        backgroundColor: primaryColor.withOpacity(0.95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'SEND',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
