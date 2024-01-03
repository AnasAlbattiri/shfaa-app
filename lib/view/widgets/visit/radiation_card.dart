import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/logic/controller/radiation_controller.dart';
import 'package:patient_app/utils/constants.dart';
import 'package:patient_app/view/screens/results/rad_results_screen.dart';

class RadiationCard extends StatefulWidget {
  final int encounterId;

  const RadiationCard({
    Key? key,
    required this.encounterId,
  }) : super(key: key);

  @override
  State<RadiationCard> createState() => _RadiationCardState();
}

class _RadiationCardState extends State<RadiationCard> {
  late RadiationController radiationController;

  @override
  void initState() {
    super.initState();
    radiationController =
        Get.put(RadiationController(widget.encounterId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: Column(
          children: [
            Container(
              width: 300,
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                groupValue: radiationController.activeIndex,
                children: {
                  0: Text('Resulted'),
                  1: Text('Pending'),
                },
                onValueChanged: (value) {
                  setState(() {
                    radiationController.activeIndex = value!;
                    radiationController.updatePrintFlag(widget.encounterId);
                  });
                },
              ),
            ),
            Expanded(
              child: radiationController.rays.isEmpty
                  ? Center(
                      child: Text(
                        (radiationController.activeIndex == 0)
                            ? 'No Resulted rays found'
                            : 'No Pending rays found',
                      ),
                    )
                  : radiationController.activeIndex == 0 ? radiationActiveList() : radiationPendingList(),
            ),
          ],
        ),
      );
    });
  }

  Widget radiationActiveList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final ray = radiationController.rays[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            width: double.maxFinite,
            height: 150,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                    'assets/images/radiology.png',
                    width: 44,
                    fit: BoxFit.cover,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ray.testDesc,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        ray.result,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        ray.orderStatusDesc,
                        style: TextStyle(
                          fontFamily: 'Circular',
                          color: wColor,
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
                                '${ray.orderDateStr}  ${ray.str}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Circular',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: 75,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => RadResultsScreen(),
                                  );
                                },
                                child: const Text(
                                  'Results',
                                  style: TextStyle(
                                    color: wColor,
                                    fontFamily: 'Circular',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: radiationController.rays.length,
    );
  }

  Widget radiationPendingList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final ray = radiationController.rays[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            width: double.maxFinite,
            height: 160,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                    'assets/images/radiology.png',
                    width: 44,
                    fit: BoxFit.cover,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ray.testDesc,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        ray.result,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: wColor,
                          fontFamily: 'Circular',
                        ),
                      ),
                      Text(
                        ray.orderStatusDesc,
                        style: TextStyle(
                          fontFamily: 'Circular',
                          color: wColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 170,
                        height: 28,
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
                                '${ray.orderDateStr}  ${ray.str}',
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
                )
              ],
            ),
          ),
        );
      },
      itemCount: radiationController.rays.length,
    );
  }
}
