import 'dart:async';

import 'package:btcpl/moduls/attendance_page/sub_widget/attendance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_routes.dart';
import '../../utils/pref.dart';
import '../../utils/tms_color.dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_normaltext.dart';
import 'attendance_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceController attendanceController = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    RxString workingHours() {
      final inDuration = attendanceController.parseTimeDuration(
          time: attendanceController.captureCheckInTime);
      final outDuration = attendanceController.parseTimeDuration(
          time: attendanceController.captureCheckOutTime);

      String totalDuration = "${outDuration - inDuration}";

      RxString time = totalDuration
          .replaceFirst('.000000', '')
          .obs;

      return time;
    }

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.dashboardScreen);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Attendance',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Get.offAndToNamed(AppRoutes.dashboardScreen);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: AppColor.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Obx(
                    () =>
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TmsText(
                              text: attendanceController.currentTime.value,
                              color: Color(0xff585858),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TmsText(
                            text: DateFormat('EEEE, d MMMM, yyyy')
                                .format(DateTime.now()),
                            fontSize: 16,
                            color: Color(0xff585858),
                          ),
                          if(attendanceController.attendanceStates == "A")...{
                            SizedBox(
                              height: 5,
                            ),
                            TmsText(
                              text: "The attendance request has been successfully submitted however, it has not yet been approved.",
                              fontSize: 12,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          },
                          SizedBox(
                            height: AppSize
                                .size(context)
                                .height * 0.10,
                          ),
                          if (attendanceEnum.value == AttendanceEnum.clockIn) ...{
                            InkWell(
                              onTap: () {
                                attendanceController.captureCheckInTime =
                                    attendanceController.currentTime.value;
                                attendanceController.attendanceDate.value =
                                    DateFormat('yyyy-MM-dd hh:mm:ss a ')
                                        .format(DateTime.now());
                                attendanceController.userAttendanceApi(context);
                              },
                              child: Image(
                                height: AppSize.size(context).height * 0.17,
                                image: AssetImage(
                                    'assets/images/attendance_image/clockin (2).png'),
                              ),
                            ),
                          } else
                            if (attendanceEnum.value ==
                                AttendanceEnum.clockOut) ...{
                              InkWell(
                                onTap: () {
                                  attendanceController.attendanceDate.value =
                                      DateFormat('yyyy-MM-dd hh:mm:ss a ')
                                          .format(DateTime.now());
                                  attendanceController.userAttendanceApi(context);
                                  attendanceController.captureCheckOutTime =
                                      attendanceController.currentTime.value;
                                },
                                child: Image(
                                  height: AppSize.size(context).height * 0.17,
                                  image: AssetImage(
                                      'assets/images/attendance_image/clockout (2).png'),
                                )
                              ),
                            } else
                              if (attendanceEnum.value ==
                                  AttendanceEnum.preview) ...{
                                Image(
                                   height: AppSize.size(context).height * 0.17,
                                  image: AssetImage(
                                      'assets/images/attendance_image/TimeMarked.png'),
                                  )
                              },
                          if (attendanceEnum.value ==
                              AttendanceEnum.clockOut) ...{
                            SizedBox(
                              height: AppSize
                                  .size(context)
                                  .height * 0.04,
                            ),
                            Container(
                              height: AppSize
                                  .size(context)
                                  .height * 0.10,
                              width: AppSize
                                  .size(context)
                                  .width * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Color(0xff01c975), width: 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TmsText(
                                    text: "Current Time",
                                  ),
                                  TmsText(text: attendanceController
                                      .LiveTime()
                                      .value)
                                ],
                              ),
                            ),
                          },
                          SizedBox(
                            height: attendanceEnum.value == AttendanceEnum.clockIn
                                ? AppSize
                                .size(context)
                                .height * 0.10
                                : AppSize
                                .size(context)
                                .height * 0.04,

                          ),
                          TmsText(
                            text: Pref().getUserName(),
                            color: Color(0xff585858),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: AppSize
                                .size(context)
                                .height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TimeWidget(
                                text:
                                attendanceController.captureCheckInTime.isNotEmpty
                                    ? attendanceController.captureCheckInTime
                                    : "--:--",
                                icon: 'assets/images/attendance_image/clockin.png',
                                title: "Clock In",
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: TimeWidget(
                                  text:
                                  "${workingHours().value == "0:00:00"
                                      ? "--:--"
                                      : attendanceController.TotalCheckDuration()}",
                                  icon: 'assets/images/attendance_image/workhour.png',
                                  title: "Working Hours",
                                ),
                              ),
                              TimeWidget(
                                text: attendanceController
                                    .captureCheckOutTime.isNotEmpty
                                    ? attendanceController.captureCheckOutTime
                                    : "--:--",
                                icon: 'assets/images/attendance_image/clockout.png',
                                title: "Clock Out",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
