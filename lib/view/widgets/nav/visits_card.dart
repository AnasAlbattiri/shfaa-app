import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/logic/controller/visits_controller.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/widgets/visit/visit_details_screen.dart';
import '../../../data/model/visits_model.dart';

class VisitsCard extends StatefulWidget {
  const VisitsCard({
    Key? key,
  }) : super(key: key);

  @override
  State<VisitsCard> createState() => _VisitsCardState();
}

class _VisitsCardState extends State<VisitsCard> {
  late VisitsController visitsController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];
    visitsController = Get.put(VisitsController(patientId));
  }

  void onVisitSelected(VisitsModel visit) {
    int encounterId = visit.id; // Assuming this is the encounterId
    Get.to(() => VisitDetailsScreen(), arguments: {'id': encounterId});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (visitsController.isLoading.isTrue) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (visitsController.visits.isNotEmpty) {
        return visitsList(visitsController: visitsController);
      } else {
        return Center(
          child: Text(
            'No Visits Found',
            style: TextStyle(color: bColor, fontFamily: 'Circular',),
          ),
        );
      }
    });
  }
}

class visitsList extends StatelessWidget {
  const visitsList({
    super.key,
    required this.visitsController,
  });

  final VisitsController visitsController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final visit = visitsController.visits[index];
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
            ),
            child: Container(
              width: double.maxFinite,
              height: 175,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.80),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/visits.png',
                      width: 45,
                      fit: BoxFit.cover,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${visit.locationDescEng}',
                          maxLines: 2,
                          style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontFamily: 'Circular',
                          ),
                        ),
                      ),
                      Text(
                        '${visit.encounterStatusDescEng}',
                        style: TextStyle(
                          fontSize: 14,
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        '${visit.siteDescEng}',
                        style: TextStyle(
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        '${visit.encounterTypeDescEng}',
                        style: TextStyle(
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Dr.${visit.doctorName}',
                          maxLines: 2,

                          style: TextStyle(
                            color: wColor,
                            fontFamily: 'Circular',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.calendar_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 12),
                              child: Text(
                                '${visit.encounterDateFormat}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Circular',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 8),
                    child: IconButton(onPressed: (){
                      int encounterId =
                          visit.id; // Get encounterId from the selected visit
                      Get.to(() => VisitDetailsScreen(),
                          arguments: {'id': encounterId});
                    } ,icon: Icon(Icons.arrow_forward_ios_rounded, color: wColor,),),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: visitsController.visits.length,
      ),
    );
  }
}
