import 'package:flutter/material.dart';
import 'package:patient_app/view/widgets/print/pw_text_field_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../../data/model/rad_results_model.dart';
import '../../../data/model/radiation_model.dart';
pw.Widget pwAllFields(
    RadResultsModel radResults,
    RadiationModel radiationModel,
    ) {
  return pw.Container(
    padding: pw.EdgeInsets.symmetric(horizontal: 23),
    child: pw.Column(
      children: [
        pw.SizedBox(
          height: 20,
        ),
        pwTextFieldWidget(
          'Test Name',
          '${radiationModel.testDesc}',
          readOnly: true,
        ),
        pw.SizedBox(
          height: 10,
        ),
        pwTextFieldWidget(
          'Test Date',
          '${radResults.str}',
          readOnly: true,
        ),
        pw.SizedBox(
          height: 10,
        ),
        pwTextFieldWidget(
          'Test Time',
          '${radResults.str2}',
          readOnly: true,
        ),
        pw.SizedBox(
          height: 10,
        ),
        pwTextFieldWidget(
          'Test Result',
          '${radResults.bodyText}',
          isMultiline: true,
        ),
        pw.SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}