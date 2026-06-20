import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../model/drs_model/drs_generate/vendor_type_model.dart';
import '../../../model/drs_model/drs_generate/vendor_list_model.dart';
import '../../../model/drs_model/drs_generate/vehicle_list_model.dart';
import '../../../model/drs_model/drs_generate/vehicle_details_model.dart';
import '../../../model/drs_model/drs_generate/driver_list_model.dart';
import '../../../model/drs_model/drs_generate/driver_details_model.dart';
import '../../../model/drs_model/drs_generate/delivery_agent_model.dart';
import '../../../model/drs_model/drs_generate/crossing_agent_model.dart';
import '../../../model/drs_model/drs_generate/available_docket_model.dart';
import '../../../model/drs_model/drs_generate/prepare_drs_model.dart';
import '../../../utils/pref.dart';
import '../../../utils/tmsapi_method.dart';
import '../../../utils/tmsapp_api.dart';
import '../../../widgets/tost.dart';
import '../../../widgets/submit_alert_dialog.dart';

class DRSGenerateController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final manualDrsNoController = TextEditingController();
  final drsDateController = TextEditingController(text: DateFormat('dd MMM yyyy').format(DateTime.now()));
  final mobileNoController = TextEditingController();
  final driverNameController = TextEditingController();
  final loadingSupervisorController = TextEditingController();
  final manualVendorNameController = TextEditingController();
  final manualVehicleNoController = TextEditingController();
  final cnoteNoController = TextEditingController();

  // Observable Data Lists
  var vendorTypeList = <VendorTypeItem>[].obs;
  var vendorList = <VendorItem>[].obs;
  var vehicleList = <VehicleItem>[].obs;
  var driverList = <DriverListItem>[].obs;
  var deliveryAgentList = <DeliveryAgentItem>[].obs;
  var crossingAgentList = <CrossingAgentItem>[].obs;
  var availableDockets = <AvailableDocketItem>[].obs;
  var selectedDockets = <AvailableDocketItem>[].obs;

  // Selected Values
  var selectedVendorType = Rxn<VendorTypeItem>();
  var selectedVendor = Rxn<VendorItem>();
  var selectedVehicle = Rxn<VehicleItem>();
  var selectedDriver = Rxn<DriverListItem>();
  var selectedDeliveryAgent = Rxn<DeliveryAgentItem>();
  var selectedCrossingAgent = Rxn<CrossingAgentItem>();

  // Vehicle & Driver Details
  var vehicleDetails = Rxn<VehicleDetailItem>();
  var driverDetails = Rxn<DriverDetailsData>();

  @override
  void onInit() {
    super.onInit();
    fetchVendorTypes();
    fetchDeliveryAgents();
    fetchCrossingAgents();
  }

  Future<void> fetchVendorTypes() async {
    try {
      var response = await WebService.tmsPostRequest(
        url: ApiService.getVendorType,
        body: jsonEncode({"routeMode": "M", "moduleID": "4"}),
      );
      if (response.statusCode == 200) {
        var res = vendorTypeResponseFromJson(response.data);
        vendorTypeList.assignAll(res.data.venders);
      }
    } catch (e) {
      TmsToast.msg("Error fetching vendor types: $e");
    }
  }

  Future<void> fetchVendors(String vendorTypeCode) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: ApiService.getVendorsFromVendorType,
        body: jsonEncode({
          "vendor_Type": vendorTypeCode,
          "location": Pref().getBaseLocation(),
          "username": Pref().getUserId(),
          "documentType": "2"
        }),
      );
      if (response.statusCode == 200) {
        var res = vendorListResponseFromJson(response.data);
        vendorList.assignAll(res.data.venderscodes);
      }
    } catch (e) {
      TmsToast.msg("Error fetching vendors: $e");
    }
  }

  Future<void> fetchVehicles(String vendorCode, String vendorTypeCode) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: ApiService.getVehicleFromVendor,
        body: jsonEncode({
          "vendor_Type": vendorCode,
          "vendor_Type_Code": vendorTypeCode
        }),
      );
      if (response.statusCode == 200) {
        var res = vehicleListResponseFromJson(response.data);
        vehicleList.assignAll(res.data.mvLists);
      }
    } catch (e) {
      TmsToast.msg("Error fetching vehicles: $e");
    }
  }

  Future<void> fetchVehicleDetails(String vehicleNo) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: ApiService.getVehicleDetails,
        body: jsonEncode({"vehicleNo": vehicleNo}),
      );
      if (response.statusCode == 200) {
        var res = vehicleDetailsResponseFromJson(response.data);
        if (res.data.getVehicle.isNotEmpty) {
          vehicleDetails.value = res.data.getVehicle.first;
        }
      }
    } catch (e) {
      TmsToast.msg("Error fetching vehicle details: $e");
    }
  }

  Future<void> fetchDrivers(String prefix) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: "${ApiService.getDriverList}?Prefix=$prefix",
        body: "",
      );
      if (response.statusCode == 200) {
        var res = driverListResponseFromJson(response.data);
        driverList.assignAll(res.data);
      }
    } catch (e) {
      TmsToast.msg("Error fetching drivers: $e");
    }
  }

  Future<void> fetchDriverDetails(String driverName) async {
    try {
      var response = await WebService.tmsPostRequest(
        url: "${ApiService.getDriverDetails}?DriverName=$driverName",
        body: "",
      );
      if (response.statusCode == 200) {
        var res = driverDetailsResponseFromJson(response.data);
        driverDetails.value = res.data;
        mobileNoController.text = res.data.mobileno;
        driverNameController.text = res.data.driver_Name;
      }
    } catch (e) {
      TmsToast.msg("Error fetching driver details: $e");
    }
  }

  Future<void> fetchDeliveryAgents() async {
    try {
      var response = await WebService.tmsPostRequest(
        url: "${ApiService.getDeliveryAgent}?BaseLocationCode=${Pref().getBaseLocation()}",
        body: "",
      );
      if (response.statusCode == 200) {
        var res = deliveryAgentResponseFromJson(response.data);
        deliveryAgentList.assignAll(res.data);
      }
    } catch (e) {
      TmsToast.msg("Error fetching delivery agents: $e");
    }
  }

  Future<void> fetchCrossingAgents() async {
    try {
      var body = jsonEncode({
        "vendor_Type": "XX9",
        "location": Pref().getBaseLocation(),
        "username": Pref().getUserId(),
        "documentType": "2"
      });
      WebService.logger.i("Fetching Crossing Agents with body: $body");
      
      var response = await WebService.tmsPostRequest(
        url: ApiService.getCrossingAgent,
        body: body,
      );
      
      if (response.statusCode == 200) {
        WebService.logger.d("Crossing Agents Response: ${response.data}");
        var res = crossingAgentResponseFromJson(response.data);
        
        if (res.status == 200) {
          crossingAgentList.value = res.data.venderscodes;
          WebService.logger.i("Crossing Agents loaded: ${crossingAgentList.length}");
        } else {
          crossingAgentList.clear();
          WebService.logger.w("No Crossing Agents found: ${res.message}");
        }
      }
    } catch (e) {
      WebService.logger.e("Error fetching crossing agents", error: e);
      TmsToast.msg("Error fetching crossing agents: $e");
    }
  }

  Future<void> fetchAvailableDockets() async {
    try {
      var body = jsonEncode({
        "fromdt": DateFormat('d MMM yyyy').format(DateTime.now().subtract(const Duration(days: 30))),
        "todt": DateFormat('d MMM yyyy').format(DateTime.now()),
        "dttyp": "1",
        "paybas": "All",
        "trn": "All",
        "bustyp": "All",
        "status": "All",
        "doctyp": "DRS",
        "baseLocationCode": Pref().getBaseLocation(),
        "docketList": "",
        "alloted_To": "",
        "loadingBy": "",
        "chrgType": "",
        "baseCompanyCode": Pref().getCompanyCode()
      });
      WebService.logger.i("Fetching Available Dockets with body: $body");

      var response = await WebService.tmsPostRequest(
        url: ApiService.avalabledocketinPRSDRS,
        body: body,
      );
      if (response.statusCode == 200) {
        WebService.logger.d("Available Dockets Response: ${response.data}");
        var res = availableDocketResponseFromJson(response.data);
        availableDockets.assignAll(res.data);
      }
    } catch (e) {
      WebService.logger.e("Error fetching available dockets", error: e);
      TmsToast.msg("Error fetching available dockets: $e");
    }
  }

  var isLoadingSubmit = false.obs;

  Future<void> submitDRS() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (selectedDockets.isEmpty) {
      TmsToast.msg("Please select at least one docket");
      return;
    }

    var isMarket = selectedVendorType.value?.vendorType_Code == "XX";

    if (!isMarket) {
      if (selectedVendor.value == null) {
        TmsToast.msg("Please select a vendor");
        return;
      }
      if (selectedVehicle.value == null) {
        TmsToast.msg("Please select a vehicle");
        return;
      }
    } else {
      if (manualVendorNameController.text.isEmpty) {
        TmsToast.msg("Please enter vendor name");
        return;
      }
      if (manualVehicleNoController.text.isEmpty) {
        TmsToast.msg("Please enter vehicle number");
        return;
      }
    }

    isLoadingSubmit.value = true;
    try {
      var request = PrepareDRSRequest(
        drsNo: manualDrsNoController.text,
        drscDate: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now()),
        vendorcode: isMarket ? "8888" : (selectedVendor.value?.vendor_Code ?? ""),
        vendorname: isMarket ? manualVendorNameController.text : (selectedVendor.value?.vendor_Name ?? ""),
        vehicleNo: isMarket ? manualVehicleNoController.text : (selectedVehicle.value?.vehno ?? ""),
        vendor_type: selectedVendorType.value?.vendorType_Code ?? "",
        tripsheetno: "",
        baseUserName: Pref().getUserId(),
        baseLocationCode: Pref().getBaseLocation(),
        baseCompanyCode: Pref().getCompanyCode(),
        baseFinYear:  Pref().getFinYear(),
        doc_Type: "DRS",
        ismktVeh: isMarket ? "Y" : "N",
        deliveryAgent: selectedDeliveryAgent.value?.userId ?? "",
        crossingAgent: selectedCrossingAgent.value?.vendorcode ?? "",
        rcBookNo: vehicleDetails.value?.rcBookNo ?? "",
        usedcapacity: vehicleDetails.value?.usedcapacity ?? 0,
        insuranceValDt: vehicleDetails.value?.insuranceValDt ?? "",
        vehprmdt: vehicleDetails.value?.vehprmdt ?? "",
        capacity: vehicleDetails.value?.capacity ?? 0,
        registrationDt: vehicleDetails.value?.registrationDt ?? "",
        engineNo: vehicleDetails.value?.engineNo ?? "",
        ftltyPe: vehicleDetails.value?.ftltyPe ?? "",
        vehicle_Type: vehicleDetails.value?.vehicle_Type ?? "",
        chasisNo: vehicleDetails.value?.chasisNo ?? "",
        fitnessValDt: vehicleDetails.value?.fitnessValDt ?? "",
        wtloaded: 0,
        startKM: vehicleDetails.value?.startKM ?? 0,
        driver_Id: driverDetails.value?.driver_Id ?? 0,
        driver_Name: driverDetails.value?.driver_Name ?? "",
        mobileno: mobileNoController.text,
        license_No: driverDetails.value?.license_No ?? "",
        issue_By_RTO: driverDetails.value?.issue_By_RTO ?? "",
        valdity_date: driverDetails.value?.valdity_date ?? "",
        drsGenerateList: selectedDockets.map((d) => DrsGenerateItem(
          dockno: d.dockno,
          docksf: d.docksf,
          orgncd: d.orgncd,
          pkgsno: d.pkgsno,
          arrPkgQty: d.arrPkgQty,
          pendPkgQty: d.pendPkgQty,
          payBas: d.payBas,
          actuwt: d.actuwt,
          arrWeightQty: d.arrWeightQty,
          chrgwt: d.chrgwt,
          trN_MOD: d.trN_MOD,
          dkttot: 1,
          desT_CD: d.desT_CD,
          pdcdt: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now()),
          bkg_Date: d.bkg_Date,
          rate: 0,
          ratetype: 0,
        )).toList(),
      );

      String requestJson = prepareDRSRequestToJson(request);
      WebService.logger.i("Submitting DRS with body: $requestJson");

      var response = await WebService.tmsPostRequest(
        url: ApiService.prepareDRS,
        body: requestJson,
      );

      if (response.statusCode == 200) {
        WebService.logger.d("Submit DRS Response: ${response.data}");
        var resData = jsonDecode(response.data);
        if (resData['status'] == 200 || resData['statusCode'] == 200) {
          String drsNo = resData['data'] ?? "";
          TmsAlertDialog(
            context: Get.context!,
            title: "DRS Prepared Successfully",
            description: "DRS No: $drsNo",
            onTapText: "OK",
            buttonSize: const Size(100, 40),
            isShowImage: true,
            onPressed: () {
              Get.back(); // close dialog
              Get.back(); // go back to previous screen
            },
          );
        } else {
          String errorMsg = "Failed to prepare DRS";
          if (resData['errors'] != null && resData['errors']['message'] != null) {
            errorMsg = resData['errors']['message'];
          } else if (resData['message'] != null) {
            errorMsg = resData['message'];
          }
          WebService.logger.e("Prepare DRS Error: $errorMsg");
          TmsToast.msg(errorMsg);
        }
      } else {
        WebService.logger.e("Server Error: ${response.statusCode}");
        TmsToast.msg("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      WebService.logger.e("Error preparing DRS", error: e);
      TmsToast.msg("Error preparing DRS: $e");
    } finally {
      isLoadingSubmit.value = false;
    }
  }

  void toggleDocketSelection(AvailableDocketItem docket) {
    if (selectedDockets.contains(docket)) {
      selectedDockets.remove(docket);
    } else {
      selectedDockets.add(docket);
    }
  }

  var isLoadingAddCnote = false.obs;

  Future<void> addCnoteManual() async {
    String cnote = cnoteNoController.text.trim();
    if (cnote.isEmpty) {
      TmsToast.msg("Please enter Cnote No");
      return;
    }

    isLoadingAddCnote.value = true;
    try {
      var body = jsonEncode({
        "fromdt": "1 Jan 1990",
        "todt": DateFormat('d MMM yyyy').format(DateTime.now()),
        "dttyp": "1",
        "paybas": "All",
        "trn": "All",
        "bustyp": "All",
        "status": "All",
        "doctyp": "DRS",
        "baseLocationCode": Pref().getBaseLocation(),
        "docketList": cnote,
        "alloted_To": "",
        "loadingBy": "",
        "chrgType": "",
        "baseCompanyCode": Pref().getCompanyCode()
      });
      WebService.logger.i("Adding Cnote Manual with body: $body");

      var response = await WebService.tmsPostRequest(
        url: ApiService.avalabledocketinPRSDRS,
        body: body,
      );
      if (response.statusCode == 200) {
        WebService.logger.d("Add Cnote Response: ${response.data}");
        var res = availableDocketResponseFromJson(response.data);
        if (res.data.isNotEmpty) {
          var docket = res.data.first;
          if (!selectedDockets.any((element) => element.dockno == docket.dockno)) {
            selectedDockets.add(docket);
            cnoteNoController.clear();
            TmsToast.msg("Cnote added successfully");
          } else {
            TmsToast.msg("Cnote already added");
          }
        } else {
          TmsToast.msg("Cnote not found or not available");
        }
      } else {
        WebService.logger.e("Server Error while adding Cnote: ${response.statusCode}");
        TmsToast.msg("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      WebService.logger.e("Error adding Cnote", error: e);
      TmsToast.msg("Error adding Cnote: $e");
    } finally {
      isLoadingAddCnote.value = false;
    }
  }
}
