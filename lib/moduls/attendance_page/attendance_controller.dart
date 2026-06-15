// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_routes.dart';
import '../../model/attendance/attendanc_response.dart';
import '../../model/attendance/attendance_request.dart';
import '../../model/attendance/getattendance_res.dart';
import '../../utils/location_service.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/app_size.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/submit_alert_dialog.dart';
import '../../widgets/tost.dart';

enum AttendanceEnum {
  clockIn,
  clockOut,
  preview,
}

enum WorkForHomeEnum {
  failRequest,
  requestForHome,
}

Rx<AttendanceEnum> attendanceEnum = AttendanceEnum.clockIn.obs;
Rx<WorkForHomeEnum> workForHomeEnum = WorkForHomeEnum.failRequest.obs;

class AttendanceController extends GetxController {
  String captureCheckInTime = '';
  String captureCheckOutTime = '';
  late GetattendanceRes getattendanceRes;
  RxString currentTime = ''.obs;
  RxString attendanceDate = ''.obs;
  RxString attendanceStates = ''.obs;
  LocationModule locationModule = LocationModule();
  DateTime? clockInDateTime;
  DateTime? liveDateTime;
  MethodChannel channel = MethodChannel("tms.com/method");
  Map<String, dynamic>? Scheduler;

  ///userApiVar
  bool isClockIn = true;
  bool isAttendanceRequest = false;
  int attendanceId = 0;

  @override
  void onInit() async {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${Pref().getAttendanceId()}");
    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final formatter = DateFormat('hh:mm:ss a');
      currentTime.value = formatter.format(now);
    });
    if (await handleLocationPermission()) {
      await locationModule.init();
    }

    super.onInit();
  }

  ///method channel
  Future<dynamic> setScheduler() async {
    print("><><><><><><><><><><><><><><><><><><><>${Scheduler}<><><><><><><><><><><><><><><><><><");
    Scheduler =  {
      "token": Pref().getToken(),
      "attendance_id": Pref().getAttendanceId(),
      "user_id": Pref().getUserId(),
    };
    await channel.invokeListMethod(
      "tms.com/method/schedule",
        Scheduler
    );
  }

  Duration parseTimeDuration({required String time}) {
    if (captureCheckInTime.isEmpty || captureCheckOutTime.isEmpty) {
      return const Duration(seconds: 0);
    } else {
      final parts = time.split(':');
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      final seconds = int.parse(parts[2].substring(0, 2));
      final period = parts[2].substring(2);

      final totalSeconds = hours * 3600 + minutes * 60 + seconds;
      if (period == 'PM') {
        return Duration(seconds: totalSeconds + 12 * 3600);
      } else {
        return Duration(seconds: totalSeconds);
      }
    }
  }

  Future<void> userAttendanceApi(BuildContext context) async {
    TmsLoader().show();
    if (locationModule.lastLocation?.latitude == null ||
        locationModule.lastLocation?.longitude == null) {
      TmsLoader().hide();
      locationModule.init();
      TmsToast.msg("Please on Location");
    } else {
      var response = await WebService.tmsPostTokenRequest(
        url: ApiService.attendance,
        body: attendanceRequestToJson(
          AttendanceRequest(
            isAttendanceRequest: attendanceEnum.value == AttendanceEnum.clockOut
                ? false
                : isAttendanceRequest,
            isClockIn: attendanceEnum.value == AttendanceEnum.clockOut
                ? false
                : isClockIn,
            attandanceId: int.parse(Pref().getAttendanceId()),
            location:
                '${locationModule.lastLocation?.latitude} : ${locationModule.lastLocation?.longitude}',
            userId: Pref().getUserId(),
            attendanceDate: attendanceDate.value,
          ),
        ),
      );

      TmsLoader().hide();
      try {
        if (response.statusCode == 200) {
          AttendanceResponse attendanceResponse =
              attendanceResponseFromJson(response.data);
          Pref().saveAttendanceId(val: attendanceResponse.data.id.toString());
          print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${Pref().getAttendanceId()}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          print(Pref().getAttendanceId());
          if (attendanceEnum.value == AttendanceEnum.clockIn) {
            print("call");
            if (attendanceResponse.data.isAttendanceRequest == false) {
              setScheduler();
              TmsAlertDialog(
                context: context,
                title: "Clock In",
                description: "You’re successfully clock in.",
                onTapText: 'Okay',
                isShowImage: true,
                buttonSize: Size(AppSize.size(context).width * 0.30,
                    AppSize.size(context).height * 0.045),
                onPressed: () {
                  attendanceEnum.value = AttendanceEnum.clockOut;
                  Get.back();
                  Get.back();
                },
              );
            } else {

              Pref().saveClockInTime(val: attendanceDate.value);
              isAttendanceRequest = attendanceResponse.data.isAttendanceRequest;
              if (workForHomeEnum.value == WorkForHomeEnum.failRequest) {
                TmsAlertDialog(
                  context: context,
                  title: "Clock In",
                  description:
                      "Since you are not currently at the office, could you please submit a request to work from home ?",
                  onTapText: 'Okay',
                  isShowImage: false,
                  buttonSize: Size(AppSize.size(context).width * 0.30,
                      AppSize.size(context).height * 0.045),
                  onPressed: () {
                    setScheduler();
                    print(
                        ",,,,,,,,,,,,,,,,,,,,,,,,...........................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<tap");
                    attendanceId = attendanceResponse.data.id;
                    workForHomeEnum.value = WorkForHomeEnum.requestForHome;
                    userAttendanceApi(context);
                    Get.back();
                    Get.back();
                  },
                );
              } else {
                setScheduler();
                isAttendanceRequest = false;
                Get.snackbar(
                  "Attendance Request",
                  "Attendance Request submitted successfully..",
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 2),
                  backgroundColor: Color(0xff00CA75),
                  colorText: Colors.white,
                  borderRadius: 10.0,
                  margin: EdgeInsets.all(10.0),
                );
              }
            }
          } else if (attendanceEnum.value == AttendanceEnum.clockOut) {
            Pref().saveAttendanceId(val: "0");
            TmsAlertDialog(
              isShowImage: true,
              context: context,
              title: "Clock Out",
              description: "You’re successfully clock out.",
              onTapText: 'Okay',
              buttonSize: Size(AppSize.size(context).width * 0.30,
                  AppSize.size(context).height * 0.045),
              onPressed: () {
                Pref().saveAttendanceId(val: "0");
                print(Pref().getAttendanceId());
                Get.back();
                Get.back();
              },
            );
          }
        } else {
          TmsToast.msg('Something is Wrong');
        }
      } catch (error) {
        TmsToast.msg('Attendance Api catch $error');
      }
    }
  }

  ///Get Attendance Api
  Future<GetattendanceRes?> getAttendance(BuildContext context) async {
    TmsLoader().show();
    String url =
        "${ApiService.getAttendance}?UserId=${Pref().getUserId()}&AttendanceDate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}";
    final dio.Response response = await WebService.tmsGetRequest(url);
    TmsLoader().hide();
    try {
      if (response.statusCode == 200) {
        getattendanceRes = getattendanceResFromJson(response.data);
        Pref().saveAttendanceId(val: getattendanceRes.data[0].attendanceId.toString());
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${Pref().getAttendanceId()}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        attendanceStates.value = getattendanceRes.data[0].attendanceStatus;
        if (getattendanceRes.data[0].isClockIn == false &&
            getattendanceRes.data[0].isClockOut == false) {
          Pref().saveAttendanceId(val: "0");

          print(Pref().getAttendanceId());
        }
        Get.toNamed(AppRoutes.attendanceScreen);
        attendanceDate.value = getattendanceRes.data.first.inTime;
        await Pref().setCheckOutId(
            val: getattendanceRes.data[0].attendanceId.toString());
        captureCheckInTime = getattendanceRes.data.first.inTime;
        captureCheckOutTime = getattendanceRes.data.first.outTime;

        if (getattendanceRes.data.first.isClockIn == false &&
            getattendanceRes.data.first.isClockOut == false) {
          attendanceEnum.value = AttendanceEnum.clockIn;
        } else if (getattendanceRes.data.first.isClockIn == true &&
            getattendanceRes.data.first.isClockOut == true) {
          attendanceEnum.value = AttendanceEnum.preview;
        } else {
          attendanceEnum.value = AttendanceEnum.clockOut;
        }
      } else {
        TmsToast.msg("Server Error");
      }
    } catch (error) {
      print(error.reactive);
    }
    return null;
  }

  void calculateDistance() async {
    double distance = await locationModule.getCurrentDistance();
    if (kDebugMode) {
      print('Distance: $distance meters');
    }
  }

  ///Handle Location Permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.'))
      // );
      return false;
    }
    return true;
  }

  ///PASS LIVE TIME
  RxString LiveTime() {
    String clockInTime = captureCheckInTime;
    String liveTime = currentTime.value;

    DateTime clockInDateTime = parseTimeString(clockInTime);
    DateTime liveDateTime = parseTimeString(liveTime);

    Duration duration = liveDateTime.difference(clockInDateTime);

    return "${formatDuration(duration)}".obs;
  }

  DateTime parseTimeString(String timeString) {
    /// Split the time string into hours, minutes, and AM/PM
    List<String> timeParts = timeString.split(' ');
    List<String> time = timeParts[0].split(':');

    /// Extract hours, minutes, and AM/PM
    int hours = int.parse(time[0]);
    int minutes = int.parse(time[1]);
    int second = int.parse(time[2]);
    String ampm = timeParts[1];

    /// Adjust hours for PM
    if (ampm == 'PM' && hours < 12) {
      hours += 12;
    }

    return DateTime(2022, 1, 1, hours, minutes, second);
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    return "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String TotalCheckDuration() {
    String clockInTime = captureCheckInTime;
    String endTime = captureCheckOutTime;

    DateTime clockInDateTime = parseTimeString(clockInTime);
    DateTime liveDateTime = parseTimeString(endTime);

    Duration duration = liveDateTime.difference(clockInDateTime);

    return "${formatDuration(duration)}";
  }
}
