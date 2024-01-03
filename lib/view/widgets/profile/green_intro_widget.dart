import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

Widget greenIntroWidget(){
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/mask.png',),
            fit: BoxFit.cover,
        )
    ),
    height: Get.height*0.6,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SvgPicture.asset('assets/images/leaf icon.svg'),

        const SizedBox(
          height: 20,
        ),

        SvgPicture.asset('assets/images/greenTaxi.svg')

      ],
    ),
  );
}

Widget greenIntroWidgetWithoutLogos({String title = "",String? subtitle}){
  return Stack(
    children: [
      AspectRatio(
        aspectRatio: 16 / 5, // Example aspect ratio
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mask.png', ),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),

          ),
          ),
          height: Get.height*0.3,
          child: Container(
              height: Get.height*0.1,
              width: Get.width,
              margin: EdgeInsets.only(bottom: Get.height*0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold,
                    color: wColor,
                  ),),
                  if(subtitle != null) Text(subtitle,style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold,
                    color: wColor,
                  ),),
                ],
              )),

        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 160, top: 15),
        child: Text('Profile', style: TextStyle(color: wColor, fontFamily: 'Circular', fontSize: 22),),
      ),

    ],
  );
}