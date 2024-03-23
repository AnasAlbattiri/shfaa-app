import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patient_app/utils/constants.dart';
import '../../../logic/controller/rad/all_rays_controller.dart';
import '../rad/rad_results_screen.dart';

class AllRaysScreen extends StatefulWidget {

  const AllRaysScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllRaysScreen> createState() => _AllRaysScreenState();
}

class _AllRaysScreenState extends State<AllRaysScreen> {
  late AllRaysController allRaysController;

  @override
  void initState() {
    super.initState();
    final int patientId = Get.arguments['patientId'];

    allRaysController =
        Get.put(AllRaysController(patientId, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            const Text(
              'All radiology',
              style: TextStyle(
                fontFamily: 'Circular',
                color: wColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      child: CupertinoSlidingSegmentedControl(
                        padding: const EdgeInsets.all(5),
                        groupValue: allRaysController.activeIndex,
                        children: {
                          0: Text('Resulted'),
                          1: Text('Pending'),
                        },
                        onValueChanged: (value) {
                          setState(() {
                            final int patientId = Get.arguments['patientId'];
                            allRaysController.activeIndex = value!;
                            allRaysController.updatePrintFlag(patientId);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: allRaysController.allRays.isEmpty
                          ? Center(
                        child: Text(
                          (allRaysController.activeIndex == 0)
                              ? 'No Resulted rays found'
                              : 'No Pending rays found',
                        ),
                      )
                          : allRaysController.activeIndex == 0 ? radiationActiveList() : radiationPendingList(),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget radiationActiveList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final ray = allRaysController.allRays[index];
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Container(
            width: double.maxFinite,
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
      itemCount: allRaysController.allRays.length,
    );
  }

  Widget radiationPendingList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final ray = allRaysController.allRays[index];
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
      itemCount: allRaysController.allRays.length,
    );
  }
}
