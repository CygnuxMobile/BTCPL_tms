import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../app_routes.dart';
import '../../environments .dart';
import '../../moduls/arrival_page/arrival_controller.dart';
import '../../moduls/drs_page/drs_controller.dart';
import '../../moduls/home_page/dash_board_controller.dart';
import '../../moduls/home_page/dash_board_screen.dart';
import '../../moduls/login_page/login_controller.dart';
import '../../moduls/stock_update_page/stock_update_controller.dart';
import '../../moduls/trecking_page/tracking_screen.dart';
import '../../moduls/unloading_page/unloading_screen_controller.dart';
import '../../utils/pref.dart';
import '../../utils/tms_color.dart';
import '../app_size.dart';
import '../custom_loader.dart';
import '../tms_button.dart';
import '../tms_normaltext.dart';
import '../tost.dart';

DashBoardController ctrl = Get.find<DashBoardController>();
ArrivalController ctrl1 = Get.put(ArrivalController());
DRSController drsController = Get.put(DRSController());
UnloadingScreenController unloadingScreenController = Get.put(UnloadingScreenController());
LoginController loginController = Get.put(LoginController());
final _formKey1 = GlobalKey<FormState>();
StockUpdateController stockUpdateController = Get.put(StockUpdateController());
AppLoader appLoader = AppLoader();
RxBool isHst = Pref().getHstMode().obs;

/// Drawer
Drawer drawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.all(10.0),
                width: AppSize.size(context).width * 0.20,
                height: AppSize.size(context).height * 0.08,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image(
                      image: const AssetImage('assets/images/launcher-icon-tms.jpg'),
                      fit: BoxFit.cover,
                    ),
                    // child:
                  ),
                ),
              ),
              Text(Pref().getUserName()),
              Text(Pref().getCompanyCode()),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Hst Mode",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() {
                  return Switch(
                    value: isHst.value,
                    onChanged: (value) {
                      isHst.value = value;
                      Pref().setHstMode(value: isHst.value);
                    },
                  );
                })
              ],
            ),

            // CustomListTile(
            //   name: 'GCN',
            //   icon: HugeIcons.strokeRoundedFile01,
            //   onTap: () {
            //     DocketDialog();
            //   },
            // ),
            //  CustomListTile(
            //   name: 'DRS Generate',
            //   icon: HugeIcons.strokeRoundedArrange,
            //   onTap: () {
            //     dashBordMenuEnum = DashBordMenuEnum.drsGenerate;
            //     Get.toNamed(AppRoutes.drsGenerateScreen);
            //   },
            // ),
            CustomListTile(
              name: 'Logout',
              icon: HugeIcons.strokeRoundedLogout01,
              onTap: () {
                ctrl.logoutDialog();
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Center(child: Text(AppEnvironments.version)),
      ],
    ),
  );
}

/// drawer custom list view
class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.name, required this.onTap, required this.icon})
      : super(key: key);

  final String name;
  final List<List<dynamic>> icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          HugeIcon(
            icon: icon,
            color: const Color(0xff232F34),
            size: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

/// docket detail bottomSheet
Future<void> customBottomSheet(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: Get.context!,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return Padding(
        padding: MediaQuery.of(bc).viewInsets,
        child: Container(
          height: AppSize.size(context).height / 1.8,
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const TmsText(
                      text: 'Enter Docket number',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xff232F34),
                        size: 20,
                      ),
                      onPressed: () {
                        Get.back();
                        ctrl.docketNumber.clear();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: ctrl.docketNumber,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'e.g.AHM_22000218',
                      labelStyle: TextStyle(color: Color(0xff232F34)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Docket number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xff232F34),
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: TmsText(
                        text:
                            'You may enter more than one docket using comma "," \ne.g.AHM_22000218,AHM_22000217',
                        fontSize: 15,
                        color: AppColor.bloodRed,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TmsButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Get.back();
                      Get.toNamed(AppRoutes.docketDetails);
                    }
                  },
                  text: ' Submit',
                  size: const Size(double.infinity, 50),
                ),
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

/// Un-Loading bottomSheet
Future<void> customBottomSheetUnLoading(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 480.h,
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    'Un-Loading Sheet Criteria',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.deepPurple,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                      key: _formKey1,
                      child: TextFormField(
                        // controller: ctrl.thcNumberController,
                        decoration: const InputDecoration(
                          // hintText: 'Username',
                          labelText: '  Docket Number',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter GCN Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: AppSize.size(context).height * 0.22,
                          color: const Color(0xffA2A2A2),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'OR',
                          style: TextStyle(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: 10,
                            // width: deviceWidth * .40,
                            color: const Color(0xffA2A2A2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: TextFormField(
                        // controller: ctrl.fromdateCtl,
                        decoration: const InputDecoration(
                          // hintText: 'Username',
                          labelText: ' From Date',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          DateTime? date = DateTime.now();
                          // DateTime? date = DateTime(1900);
                          FocusScope.of(context).requestFocus(FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
                          // ctrl.fromdateCtl.text = formattedDate;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      child: TextFormField(
                        // controller: ctrl.todateCtl,
                        decoration: const InputDecoration(
                          // hintText: 'Username',
                          labelText: ' TO Date',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          DateTime? date = DateTime(1900);
                          FocusScope.of(context).requestFocus(FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
                          // ctrl.todateCtl.text = formattedDate;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TmsButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Get.toNamed(AppRoutes.docketDetails);
                        }
                      },
                      text: ' Search',
                      size: const Size(double.infinity, 50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

/// Arrival bottomSheet
Future<void> customBottomSheetArrival(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 480.h,
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    'Arrival Sheet Criteria',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                height: 30,
                color: Color(0xff03045E),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Form(
                      key: _formKey1,
                      child: TextFormField(
                        controller: ctrl1.vehicleNumberController,
                        decoration: InputDecoration(
                          labelText: "THC Number",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter THC Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xffA2A2A2),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'OR',
                          style: TextStyle(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: AppSize.size(context).height * 0.30,
                            color: const Color(0xffA2A2A2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: TextFormField(
                        controller: ctrl1.arrivalsFromDateCtl,
                        decoration: const InputDecoration(
                          // hintText: 'Username',
                          labelText: ' From Date',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          DateTime? date = DateTime.now();
                          // DateTime? date = DateTime(1900);
                          FocusScope.of(context).requestFocus(FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          String toDate = DateFormat('yyyy-MM-dd').format(date!);
                          ctrl1.arrivalsFromDateCtl.text = toDate;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      child: TextFormField(
                        controller: ctrl1.arrivalsToDateCtl,
                        decoration: const InputDecoration(
                          // hintText: 'Username',
                          labelText: ' TO Date',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                        onTap: () async {
                          DateTime? date = DateTime(1900);
                          FocusScope.of(context).requestFocus(FocusNode());
                          date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          String toDate = DateFormat('yyyy-MM-dd').format(date!);
                          ctrl1.arrivalsToDateCtl.text = toDate;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TmsButton(
                      onPressed: () {
                        if (ctrl1.vehicleNumberController.text.isNotEmpty ||
                            ctrl1.arrivalsFromDateCtl.text.isNotEmpty &&
                                ctrl1.arrivalsToDateCtl.text.isNotEmpty) {
                          ctrl1.getThcArrivalsData();
                          // drawerListController.thcArrivalsPost();
                          Get.back();
                          Get.toNamed(AppRoutes.arrivalScreen);
                        } else {
                          TmsToast.msg('Please fill anyone');
                        }
                      },
                      text: ' Search',
                      size: const Size(double.infinity, 50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

/// StockUpdate bottomSheet
Future<void> stockUpdateBottomSheetArrival(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black.withOpacity(0.3),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 440.h,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20, left: 30, right: 30),
                    child: Row(
                      children: [
                        Center(
                          child: Text(
                            "Enter THC Number",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          color: const Color(0xff03045E),
                          icon: const Icon(Icons.clear),
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Form(
                          key: _formKey1,
                          child: TextFormField(
                            controller: stockUpdateController.thcNumberController,
                            decoration: InputDecoration(
                              // hintText: 'Username',
                              labelText: 'THC Number',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              hintText: 'e.g. AHM_22000218',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter thc Number';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          child: TextFormField(
                            controller: stockUpdateController.stockUpdateFromDateCtl,
                            decoration: const InputDecoration(
                              // hintText: 'Username',
                              labelText: ' From Date',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                            ),
                            onTap: () async {
                              DateTime? date = DateTime.now();
                              // DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              String FromDate = DateFormat('yyyy-MM-dd').format(date!);
                              stockUpdateController.stockUpdateFromDateCtl.text = FromDate;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          child: TextFormField(
                            controller: stockUpdateController.stockUpdateToDateCtl,
                            decoration: const InputDecoration(
                              // hintText: 'Username',
                              labelText: ' TO Date',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                            ),
                            onTap: () async {
                              DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              String toDate = DateFormat('yyyy-MM-dd').format(date!);
                              stockUpdateController.stockUpdateToDateCtl.text = toDate;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TmsButton(
                          onPressed: () {
                            if (ctrl1.vehicleNumberController.text.isNotEmpty ||
                                ctrl1.arrivalsFromDateCtl.text.isNotEmpty &&
                                    ctrl1.arrivalsToDateCtl.text.isNotEmpty) {
                              Get.back();
                              // Get.toNamed(AppRoutes.stockUpdateListScreen);

                              stockUpdateController.stockUpdateListApi(context);
                            } else {
                              TmsToast.msg('Please fill anyone');
                            }
                          },
                          text: ' Search',
                          size: const Size(double.infinity, 50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

/// docket detail bottomSheet
Future<void> unlodingcustomBottomSheet(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black.withOpacity(0.3),
        child: Padding(
          padding: MediaQuery.of(bc).viewInsets,
          child: Container(
            height: AppSize.size(context).height / 1.8,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      const TmsText(
                        text: 'Enter THC number',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF023E8A),
                          size: 35,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: ctrl.thcNumber,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'THC NO',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter THC number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TmsButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.back();

                        unloadingScreenController.unloadingRequestData(context);
                        ctrl.thcNumber.clear();
                      }
                    },
                    text: ' Submit',
                    size: const Size(double.infinity, 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

Future<void> trackingCustomBottomSheet(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black.withOpacity(0.3),
        child: Padding(
          padding: MediaQuery.of(bc).viewInsets,
          child: Container(
            height: AppSize.size(context).height * 0.4,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      const TmsText(
                        text: 'Enter Docket Number',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xFF023E8A),
                          size: 20,
                        ),
                        onPressed: () {
                          ctrl.trackingNumber.clear();
                          Get.back();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: ctrl.trackingNumber,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Docket Number',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter docket number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TmsButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.back();
                        trackingController.trackingApi(context);
                        ctrl.trackingNumber.clear();
                      }
                    },
                    text: ' Submit',
                    size: const Size(double.infinity, 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}

///drs bottomSheet
Future<void> DrsBottomSheetArrival(context) async {
  final formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    isDismissible: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return LoaderOverlay(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 340.h,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20, left: 30, right: 30),
                  child: Row(
                    children: [
                      const Center(
                        child: Text(
                          'Select Drs Date',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        color: const Color(0xff03045E),
                        icon: const Icon(Icons.clear),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 05.h,
                      ),
                      Container(
                        child: Form(
                          child: TextFormField(
                            controller: drsController.drsFromDateCtl,
                            decoration: const InputDecoration(
                              // hintText: 'Username',
                              labelText: ' From Date',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                            ),
                            onTap: () async {
                              DateTime? date = DateTime.now();
                              // DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              String FromDate = DateFormat('dd MMM yyyy').format(date!);
                              drsController.drsFromDateCtl.text = FromDate;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select from date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        child: Form(
                          child: TextFormField(
                            controller: drsController.drsToDateCtl,
                            decoration: const InputDecoration(
                              // hintText: 'Username',
                              labelText: ' TO Date',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                            ),
                            onTap: () async {
                              DateTime? date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              String toDate = DateFormat('dd MMM yyyy').format(date!);
                              drsController.drsToDateCtl.text = toDate;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select to date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TmsButton(
                        onPressed: () {
                          Get.back();
                          drsController.drsListDataStatus.value = DataStatus.loading;
                          Get.toNamed(AppRoutes.drsListScreen);
                          drsController.drsListApi(context: context);
                        },
                        text: ' Search',
                        size: const Size(double.infinity, 50),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
