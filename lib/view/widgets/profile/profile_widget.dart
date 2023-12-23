import 'package:flutter/material.dart';
import 'package:patient_app/view/widgets/profile/text_widget.dart';

import '../../../utils/constants.dart';

Widget profileWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(text: AppConstants.helloNiceToMeetYou),
        textWidget(
            text: '',
            fontSize: 22,
            fontWeight: FontWeight.bold),
        const SizedBox(
          height: 40,
        ),
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 3,
                    blurRadius: 3)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              child: Text('Anooossss'),
                            ),
                          ),
                          textWidget(text: 'Anaassss'),
                          // const SizedBox(width: 10,),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  )),
              Container(
                width: 1,
                height: 55,
                color: Colors.black.withOpacity(0.2),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onSubmitted: (_) {},
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
                          color: bColor,
                        ),
                        hintText: '',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '' + " ",
                  ),
                  TextSpan(
                    text: '' + " ",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "and ",
                  ),
                  TextSpan(
                    text: '' + " ",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}