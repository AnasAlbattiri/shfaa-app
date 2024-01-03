import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:patient_app/view/widgets/auth/signup_form.dart';
import '../../../logic/controller/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../screens/auth/forget_password_screen.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _username, _password;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFieldName(text: "Username"),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: authController.userNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: "username",
                prefixIcon: Icon(
                  Icons.person,
                  color: primaryColor,
                )),
            onSaved: (username) => _username = username!,
          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Password"),
          GetBuilder<AuthController>(builder: (_){
            return TextFormField(
              textInputAction: TextInputAction.next,

              controller: authController.passwordController,
              obscureText: authController.isVisibility ? false : true,
              decoration: InputDecoration(
                hintText: "******",
                prefixIcon: Icon(
                  Icons.lock,
                  size: 26,
                  color: primaryColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    authController.visibility();
                  },
                  icon: authController.isVisibility
                      ? Icon(
                    Icons.visibility_off,
                    color: Colors.black45,
                  )
                      : Icon(
                    Icons.visibility,
                    color: Colors.black45,
                  ),
                ),
              ),
              onSaved: (password) => _password = password!,
            );
          }),
          TextButton(
            onPressed: () {
              Get.to(() => ForgetPasswordScreen());
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Circular',
                  decoration: TextDecoration.underline),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
