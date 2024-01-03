import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class AppConstants{
  static const String helloNiceToMeetYou = 'Hello, nice to meet you!';
  static const String serverIP = '194.165.140.205:7007';
}

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);
const wColor = Colors.white;
const bColor = Colors.black;
const Color mainColor = Color(0xFFFF7A00);
const encounterrId = 9577;
const patienttId = 153259;
const defaultPadding = 14.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

// Validation
String validationEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String validationName = r'^[a-z A-Z]+$';



