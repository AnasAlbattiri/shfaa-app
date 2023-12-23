import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

pw.Widget pwTextFieldWidget(
    String title,
    String hintText, {
      Function? onTap,
      bool readOnly = true,
      bool isMultiline = false,
      ScrollController? scrollController,
    }) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(
        height: 6,
      ),
      pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColors.white,
          border: pw.Border.all(color: PdfColors.black),
          // padding: pw.EdgeInsets.all(8),
        ),
        child: pw.Text(
          hintText,
          style: pw.TextStyle(
            // Define styles if needed
          ),
        ),
      )
    ],
  );
}