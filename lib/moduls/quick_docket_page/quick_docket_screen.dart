import 'package:btcpl/moduls/quick_docket_page/quick_docket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info_widget/info_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../utils/pref.dart';
import '../../widgets/app_size.dart';
import '../../widgets/custom_dropdown_search.dart';
import '../../widgets/dashboard_widgets/custom_drawer.dart';
import '../../widgets/tms_button.dart';
import '../../widgets/tms_normaltext.dart';
import '../../widgets/tost.dart';

class QuickDocketScreen extends StatefulWidget {
  const QuickDocketScreen({super.key});

  @override
  State<QuickDocketScreen> createState() => _QuickDocketScreenState();
}

class _QuickDocketScreenState extends State<QuickDocketScreen> {
  final SizedBox _sizedBox = const SizedBox(height: 8);

  final SizedBox _sizedBox12 = const SizedBox(height: 12);

  late QuickDocketController quickDocketController;

  @override
  void initState() {
    super.initState();
    quickDocketController = Get.put(QuickDocketController());
    quickDocketController.cityListApi();
    quickDocketController.getConsignorConsigneeList();
  }

  GlobalKey<FormState> originLocationFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> destinationFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> cityFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> transitModeFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> billingTypeFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> consignorFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> consigneeFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> noOfPkgsFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> approxWeightFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> customerFromKey = GlobalKey<FormState>();
  GlobalKey<FormState> invoiceNoFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black.withOpacity(0.3),
      child: WillPopScope(
        onWillPop: () async {
          quickDocketController.ctrlClear();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Quick Docket',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xff232F34),
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                  quickDocketController.ctrlClear();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                )),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sizedBox12,
                      Row(
                        children: [
                          Expanded(
                            child: noOfPackageTextField(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: approxWeightTextField(),
                          ),
                        ],
                      ),
                      _sizedBox12,
                      Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10),
                        child: const TmsText(text: 'Origin Location', fontSize: 12),
                      ),
                      originLocationDropdown(context),
                      _sizedBox12,
                      Row(
                        children: [
                          const TmsText(text: 'To City', fontSize: 12),
                          Spacer(),
                          Obx(() {
                            return Checkbox(
                              value: quickDocketController.isFreeText.value,
                              onChanged: (value) {
                                setState(() {
                                  quickDocketController.isFreeText.value = value!;
                                });
                              },
                            );
                          }),
                          const Text('Multi Enter City', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      if (quickDocketController.isFreeText.value) ...{
                        destinationLocationDropdown(context),
                      } else ...{
                        Form(
                          key: destinationFromKey,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.only(left: 8),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextFormField(
                                controller: quickDocketController.toCityController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[A-Z ]')),
                                ],
                                onChanged: (value) {
                                  quickDocketController.toCityController.text.trim();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter to city',
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.characters,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter to city';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      },
                      _sizedBox,
                      const TmsText(text: 'Billing Type', fontSize: 12),
                      _sizedBox,
                      billingTypeDropdown(context),
                      _sizedBox12,
                      Row(
                        children: [
                          const TmsText(text: 'Billing Party', fontSize: 12),
                          Spacer(),
                          InfoWidget(
                            infoText:
                                "To select Billing Party first select Origin Location and Billing Type",
                            iconData: Icons.help_outline,
                            infoTextStyle: TextStyle(color: Color(0xff232F34)),
                            iconColor: Color(0xff232F34),
                          ),
                        ],
                      ),
                      _sizedBox,
                      customerDropdown(context),
                      _sizedBox12,
                      consignorDropdown(context),
                      _sizedBox12,
                      consigneeDropdown(context),
                      _sizedBox12,
                      docketNoTextField(),
                      _sizedBox12,
                      invoiceNoTextField(),
                      _sizedBox12,
                      eWayBillTextField(),
                      const SizedBox(
                        height: 30,
                      ),
                      TmsButton(
                        text: 'Submit',
                        size: Size(double.infinity, AppSize.size(context).height * 0.06),
                        onPressed: () {
                          quickDocketController.checkFiledValue(
                            context: context,
                            noOfPkgsFromKey: noOfPkgsFromKey,
                            approxWeightFromKey: approxWeightFromKey,
                            billingTypeFromKey: billingTypeFromKey,
                            cityFromKey: cityFromKey,
                            invoiceNoFromKey: invoiceNoFromKey,
                            originLocationFromKey: originLocationFromKey,
                            consignorFromKey: consignorFromKey,
                            consigneeFromKey: consigneeFromKey,
                            transitModeFromKey: transitModeFromKey,
                          );
                        },
                      ),
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

  originLocationDropdown(context) {
    if (Pref().getBranchCode() == 'HQTR') {
      return Obx(
        () => Dropdown(
          height: 25.0.obs,
          image: "assets/images/dashboardimages/To.png".obs,
          enabled: true.obs,
          isSize: false,
          text: Pref().getBaseLocation().isEmpty
              ? '  Select Location '.obs
              : '  ${Pref().getBaseLocation()}'.obs,
          list: ctrl.location.map((element) => '${element.locCode} - ${element.locName}').toList(),
          onChanged: (value) async {
            await ctrl.getLocationCode(value!);
          },
          globalKey: originLocationFromKey,
          validator: (value) {
            if (Pref().getBaseLocation().isEmpty) {
              return 'Please Select Origin Location ';
            }
            return null;
          },
        ),
      );
    } else {
      return Dropdown(
        height: 25.0.obs,
        image: "assets/images/dashboardimages/To.png".obs,
        enabled: false.obs,
        isSize: false,
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: const Color(0xFFE9ECEF),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        text: Pref().getBaseLocation().isEmpty
            ? '  Select Location '.obs
            : '  ${Pref().getBaseLocation()}'.obs,
        list: [Pref().getBranchCode()],
        onChanged: (String) {},
      );
    }
  }

  destinationLocationDropdown(context) {
    return Obx(
      () => Form(
        key: destinationFromKey,
        child: Dropdown(
          image: "assets/images/dashboardimages/Form.png".obs,
          enabled: true.obs,
          height: 25.0.obs,
          isSize: false,
          text: '  Select to city '.obs,
          list: quickDocketController.cityList
              .map((element) => '${element.location} - ${element.cityCode}')
              .toList(),
          onChanged: (value) async {
            if (value != null) {
              quickDocketController.toCityController.text = value.split("-").first;
              quickDocketController.selectCityCode = int.parse(value.split("-").last);
            }
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${quickDocketController.selectCity}");
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${quickDocketController.selectCityCode}");
          },
          globalKey: cityFromKey,
          validator: (value) {
            if (Pref().getBaseLocation().isEmpty) {
              return 'Please Select to city ';
            }
            return null;
          },
        ),
      ),
    );
  }

  billingTypeDropdown(context) {
    return Obx(
      () => Dropdown(
        image: 'assets/images/dashboardimages/Billing Machine.png'.obs,
        height: 30.0.obs,
        enabled: true.obs,
        isSize: false,
        text: 'Select Billing Type '.obs,
        list: quickDocketController.pyaBasList.map((e) => e.codeDesc).toList(),
        onChanged: (value) {
          quickDocketController.billingSelectType(value!);
          quickDocketController.custListApi();
        },
        globalKey: billingTypeFromKey,
        validator: (value) {
          if (value == null || value == '') {
            return 'Please Select  Billing Type ';
          }
          return null;
        },
      ),
    );
  }

  customerDropdown(context) {
    return Obx(
      () => InkWell(
        onTap: () {
          if (quickDocketController.billingType.isEmpty &&
              quickDocketController.originLocation.isEmpty) {
            TmsToast.msg('Please select Origin Location && Billing Type ');
          } else if (quickDocketController.billingType.isEmpty) {
            TmsToast.msg('Please select Billing Type ');
          } else if (quickDocketController.originLocation.isEmpty) {
            TmsToast.msg('Please select Origin Location Type ');
          }
        },
        child: Dropdown(
          image: 'assets/images/dashboardimages/Get a Receipt.png'.obs,
          height: 28.0.obs,
          enabled: (quickDocketController.customerList.isNotEmpty ? true : false).obs,
          isSize: false,
          text: 'Select Billing Party '.obs,
          list: quickDocketController.customerList.map((element) => element.custnm).toList(),
          onChanged: (value) {
            quickDocketController.consignorSelectName(value!);
          },
          globalKey: customerFromKey,
          validator: (value) {
            if (value == null || value == '') {
              return 'Please Select Billing Party ';
            }
            return null;
          },
        ),
      ),
    );
  }

  noOfPackageTextField() {
    return Form(
      key: noOfPkgsFromKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        padding: const EdgeInsets.only(left: 8),
        width: double.infinity,
        child: Row(
          children: [
            Image(image: AssetImage('assets/images/dashboardimages/Product.png'), height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  autofocus: true,
                  focusNode: quickDocketController.noOfPkgsFocusNode,
                  controller: quickDocketController.noOfPackageController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      int qty = int.parse(value);
                      if (qty < 0) {
                        quickDocketController.noOfPackageController.text = '0';
                      } else if (qty >= 1000) {
                        quickDocketController.noOfPackageController.text = '1000';
                      } else {
                        print(value);
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'No. of Package',
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter No. of Package qty';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  invoiceNoTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/dashboardimages/Cheque.png'), height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Form(
                key: invoiceNoFromKey,
                child: TextFormField(
                  controller: quickDocketController.invoiceNoController,
                  decoration: const InputDecoration(
                    labelText: ' Invoice No ',
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Invoice Number';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  relivrInvoiceNoTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/dashboardimages/Cheque.png'), height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                controller: quickDocketController.invoiceNoController,
                decoration: const InputDecoration(
                  labelText: ' Invoice No ',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  docketNoTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/dashboardimages/Box.png'), height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                controller: quickDocketController.docketNoController,
                decoration: const InputDecoration(
                  labelText: ' Docket No ',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  eWayBillTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.only(left: 12),
      width: double.infinity,
      child: Row(
        children: [
          Image(image: AssetImage('assets/images/dashboardimages/E Way Bill no.png'), height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                controller: quickDocketController.eWayBillNoController,
                decoration: const InputDecoration(
                  labelText: ' EWay Bill No ',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  approxWeightTextField() {
    return Form(
      key: approxWeightFromKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        padding: const EdgeInsets.only(left: 8),
        width: double.infinity,
        child: Row(
          children: [
            Image(image: AssetImage('assets/images/dashboardimages/Scale.png'), height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  focusNode: quickDocketController.approxWeightFocusNode,
                  controller: quickDocketController.approxWeightController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      num weight = num.parse(value);
                      if (weight < 0) {
                        quickDocketController.approxWeightController.text = '0.0';
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Approx Weight',
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Approx Weight';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InfoText() {
    return Row(
      children: [
        Image(
          image: AssetImage('assets/images/dashboardimages/Info.png'),
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TmsText(
            textAlign: TextAlign.start,
            text:
                'Please enter correct docket no. \nIf you don’t have docket no. system will auto generate it.',
            fontSize: 10,
            color: Color(0xff232F34),
          ),
        ),
      ],
    );
  }

  customInfo({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/dashboardimages/Info.png'),
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TmsText(
              textAlign: TextAlign.start,
              text: text,
              fontSize: 10,
              color: Color(0xff232F34),
            ),
          ),
        ],
      ),
    );
  }

  consignorDropdown(context) {
    return Obx(
      () => Dropdown(
        image: 'assets/images/dashboardimages/Product.png'.obs,
        height: 28.0.obs,
        enabled: (quickDocketController.consignorConsigneeList.isNotEmpty ? true : false).obs,
        isSize: false,
        text: 'Select Consignor '.obs,
        list: quickDocketController.consignorConsigneeList.map((element) => element.custnm).toList(),
        onChanged: (value) {
          quickDocketController.consignorSelectName(value ?? '');
        },
        globalKey: consignorFromKey,
        validator: (value) {
          if (value == null || value == '') {
            return 'Please Select Consignor ';
          }
          return null;
        },
      ),
    );
  }

  consigneeDropdown(context) {
    return Obx(
      () => Dropdown(
        image: 'assets/images/dashboardimages/Product.png'.obs,
        height: 28.0.obs,
        enabled: (quickDocketController.consignorConsigneeList.isNotEmpty ? true : false).obs,
        isSize: false,
        text: 'Select Consignee '.obs,
        list: quickDocketController.consignorConsigneeList.map((element) => element.custnm).toList(),
        onChanged: (value) {
          quickDocketController.consigneeSelectName(value ?? '');
        },
        globalKey: consigneeFromKey,
        validator: (value) {
          if (value == null || value == '') {
            return 'Please Select Consignee ';
          }
          return null;
        },
      ),
    );
  }
}
