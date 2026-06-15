import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../environments .dart';
import '../../widgets/app_size.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  LoginController ctrl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black.withOpacity(0.3),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: SizedBox(
                height: AppSize.size(context).height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/loginimages/login_ilu 2.png',
                        fit: BoxFit.fill,
                        height: AppSize.size(context).height * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.size(context).height * 0.032,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: TmsText(
                          text: 'Login',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    SizedBox(
                      height: AppSize.size(context).height * 0.05,
                    ),
                    Form(
                      key: ctrl.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF023E8A),
                                ),
                                hintText: 'UserName'),
                            controller: ctrl.userNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Username';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: AppSize.size(context).height * 0.05,
                          ),
                          Obx(
                            () => TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF023E8A),
                                ),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () =>
                                      ctrl.isHiddenPassword.value = !ctrl.isHiddenPassword.value,
                                  child: Icon(
                                    ctrl.isHiddenPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ctrl.isHiddenPassword.value
                                        ? const Color(0xFF023E8A)
                                        : const Color(0xFF023E8A),
                                  ),
                                ),
                              ),
                              controller: ctrl.passwordController,
                              obscureText: ctrl.isHiddenPassword.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.size(context).height * 0.11,
                    ),
                    TmsButton(
                      text: 'Login',
                      onPressed: () {
                        if (ctrl.formKey.currentState!.validate()) {
                          ctrl.login(context);
                        }
                      },
                      size: Size(double.infinity, AppSize.size(context).height * 0.06),
                    ),
                    SizedBox(
                      height: AppSize.size(context).height * 0.025,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TmsText(
                        text: AppEnvironments.version,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
