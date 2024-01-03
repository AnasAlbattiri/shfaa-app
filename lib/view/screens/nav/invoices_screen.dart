import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/logic/controller/invoices_controller.dart';
import '../../../data/model/invoices_model.dart';
import '../../../utils/constants.dart';

class InvoicesScreen extends StatefulWidget {
  InvoicesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  late InvoicesController invController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    invController = Get.put(InvoicesController(patientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/invoices.png',
              height: 40,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 18,
            ),
            const Text(
              'Invoices',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: wColor,
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (invController.isLoading.isTrue) {
                return Center(child: CircularProgressIndicator());
              } else if (invController.invoices.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: invController.invoices.length,
                    itemBuilder: (context, index) {
                      final invoice = invController.invoices[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          width: double.maxFinite,
                          height: 143,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.80),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/invoices.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    color: Colors.yellow,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        invoice.invoiceNo,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: wColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        invoice.locationDescEng,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: wColor,
                                          fontSize: 14,
                                          fontFamily: 'Circular',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'Dr.${invoice.locationDescArb.toString()}',
                                        style: TextStyle(
                                          color: wColor,
                                          fontSize: 14,
                                          fontFamily: 'Circular',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        invoice.invoiceDate,
                                        style: TextStyle(
                                          color: wColor,
                                          fontSize: 14,
                                          fontFamily: 'Circular',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12.0,
                                    ),
                                    decoration: BoxDecoration(
                                        color: mainColor.withOpacity(0.90),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${invoice.amount} JOD',
                                          style: TextStyle(
                                            color: wColor,
                                            fontSize: 14,
                                            fontFamily: 'Circular',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Text(
                      'No Invoices Found',
                      style: TextStyle(
                        color: bColor,
                        fontFamily: 'Circular',
                      ),
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
