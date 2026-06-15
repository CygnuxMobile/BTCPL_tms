// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:loader_overlay/loader_overlay.dart';
import '../../app_routes.dart';
import '../../model/login_model/login_credential.dart';
import '../../model/login_model/login_details.dart';
import '../../model/login_model/login_error.dart';
import '../../utils/logging.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/tost.dart';
import '../splash_page/splash_controller.dart';

SplashScreenController splashScreenController = Get.put(SplashScreenController());

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<bool> isHiddenPassword = true.obs;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool activeConnection = false.obs;
  final log = logger;

  ///loginApi
  Future<void> login(BuildContext context) async {
    context.loaderOverlay.show();
    Response response = await WebService.tmsPostRequest(
      url: ApiService.login,
      body: loginCrediantialToJson(LoginCredential(username: userNameController.text, password: passwordController.text)),
    );
    try {
      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        log.i(jsonDecode(response.data));
        LoginDetails loginDetails = loginDetailsFromJson(response.data);
        await Pref().saveUserPassword(val: passwordController.text);
        await Pref().saveUserName(val: loginDetails.data.name);
        await Pref().saveMultiLocation(val: loginDetails.data.multiLocation);
        await Pref().saveCompanyCode(val: loginDetails.data.baseCompanyCode);
        await Pref().saveBranchCode(val: loginDetails.data.branchCode);
        await Pref().saveFinYear(val: loginDetails.data.finYear);
        await Pref().saveToken(val: loginDetails.data.token);
        await Pref().saveUserId(val: loginDetails.data.userId);
        await Pref().saveIsLogin(value: true);
        Get.offNamed(AppRoutes.dashboardScreen);
      } else {
        log.e(jsonDecode(response.data));
      }
    } catch (err) {
      log.e(err, error: 'Login Api Error');
      context.loaderOverlay.hide();
      LoginError loginError = loginErrorFromJson(response.data);
      TmsToast.msg(loginError.message);
    }
  }
}
