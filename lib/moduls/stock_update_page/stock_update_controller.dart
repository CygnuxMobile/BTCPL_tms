import 'package:btcpl/moduls/stock_update_page/stock_update_scanned_docket_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import '../../app_routes.dart';
import '../../model/stock_update/stock_update_list/stock_update_list_request.dart';
import '../../model/stock_update/stock_update_list/stock_update_list_response.dart';
import '../../model/stock_update/stock_update_submit/stock_update_submit_request.dart';
import '../../model/stock_update/stock_update_submit/stock_update_submit_response.dart';
import '../../utils/pref.dart';
import '../../utils/tmsapi_method.dart';
import '../../utils/tmsapp_api.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/stock_update_alert_dialog.dart';
import '../../widgets/submit_alert_dialog.dart';
import '../../widgets/tost.dart';

enum StockUpdateEnum {
  view,
  preview,
}

Rx<StockUpdateEnum> stockUpdateEnum = StockUpdateEnum.view.obs;

enum DAPSEnum {
  damage,
  // Access,
  pillFill,
  // Shortage,
}

Rx<DAPSEnum> dapsEnum = DAPSEnum.damage.obs;

enum DAPSImageEnum {
  damage,
  pillfill,
  none,
}

Rx<DAPSImageEnum> dapsImageEnum = DAPSImageEnum.none.obs;

class StockUpdateController extends GetxController {
  late StockUpdateListResponse stockUpdateListResponse;
  late StockUpdateSubmitResponse stockUpdateSubmitResponse;
  RxList<DocketBcSerialList> docketBcSerialList = <DocketBcSerialList>[].obs;
  TextEditingController stockUpdateFromDateCtl =
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 607))));
  FocusNode scanFocusNode = FocusNode();
  TextEditingController stockUpdateToDateCtl = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  TextEditingController thcNumberController = TextEditingController();
  TextEditingController BSNumberController = TextEditingController();
  TextEditingController bsScanController = TextEditingController();
  List<StockUpdateDataList> stockUpdatelist = <StockUpdateDataList>[];
  List<BsSerial> bsSerialListTemp = <BsSerial>[];
  int totalScan = 0;

  stockUpdateListApi(BuildContext context) async {
    AppLoader().show();
    var response = await WebService.tmsPostRequest(
      url: ApiService.stockUpdateList,
      body: stockUpdateListRequestToJson(
        StockUpdateListRequest(
          thcNo: thcNumberController.text,
          fromDate: stockUpdateFromDateCtl.text,
          toDate: stockUpdateToDateCtl.text,
          transportMode: 'S',
          baseLocationCode: Pref().getBaseLocation(),
          baseComapnyCode: Pref().getCompanyCode(),
          baseusername: Pref().getUserName(),
        ),
      ),
    );
    AppLoader().hide();
    try {
      if (response.statusCode == 200) {
        stockUpdateListResponse = stockUpdateListResponseFromJson(response.data);
        if (stockUpdateListResponse.status == 200) {
          TmsToast.msg(stockUpdateListResponse.message);
          if (thcNumberController.text.isEmpty) {
            stockUpdatelist = stockUpdateListResponse.stockUpdateDataList;
            Get.toNamed(AppRoutes.stockUpdateListScreen);
          } else {
            TmsToast.msg(stockUpdateListResponse.message);
            stockUpdatelist = stockUpdateListResponse.stockUpdateDataList;
            docketBcSerialList.value = stockUpdateListResponse.stockUpdateDataList[0].docketBcSerialsList;
            Get.toNamed(AppRoutes.stockUpdateScreen);
          }
        } else {
          TmsToast.msg(stockUpdateListResponse.message);
        }
      } else {
        TmsToast.msg("Stock update List ${response.statusMessage!}");
      }
    } catch (error) {
      TmsToast.msg('Stock update list data not found');
    }
  }

  int pktWeight(int bkgActuwt, int totalPkt) {
    int weight = 0;
    totalScan = docketBcSerialList.where((element) => element.isScan.value).length;

    if (bkgActuwt > 0) {
      double onePktWt = bkgActuwt / totalPkt;
      weight = (onePktWt * totalScan).toInt();
    }

    return weight;
  }

  StockUpdateDetails mergeDocketBcSerialList(int inx) {
    final Map<String, DocketBcSerialList> mergedMap = {};
    int pillFillCount = 0;
    int damageCount = 0;
    bsSerialListTemp.clear();
    for (var item in docketBcSerialList) {
      bsSerialListTemp.add(BsSerial(
        dockno: item.dockno,
        docksf: item.docksf,
        bcSerialNo: item.bcSerialNo,
        mf: item.mf,
        thc: item.thc,
      ));
      if (mergedMap.containsKey(item.dockno)) {
        final mergedItem = mergedMap[item.dockno]!;
        mergedItem.damageImages!.addAll(item.damageImages ?? <String>[]);
        mergedItem.pillFillImages!.addAll(item.pillFillImages ?? <String>[]);
        if (item.isPillFill.value == true) {
          pillFillCount += 1;
          print(pillFillCount);
          mergedItem.pillFillAgeCount = pillFillCount;
          print(mergedItem.pillFillAgeCount);
        }
        if (item.isDamage.value == true) {
          damageCount += 1;
          print("<${damageCount}>");
          mergedItem.damageAgeCount = damageCount;
          print(mergedItem.damageAgeCount);
        }
      } else {
        final newItem = DocketBcSerialList(
          dockno: item.dockno,
          docksf: item.docksf,
          bcSerialNo: item.bcSerialNo,
          mf: item.mf,
          thc: item.thc,
          isScan: item.isScan,
          isAccess: item.isAccess,
          isDamage: item.isDamage,
          isPillFill: item.isPillFill,
          isShortage: item.isShortage,
          pillFillAgeCount: item.isPillFill.value ? pillFillCount += 1 : 0,
          damageAgeCount: item.isDamage.value ? damageCount += 1 : 0,
          damageImages: List.from(item.damageImages ?? <String>[]),
          pillFillImages: List.from(item.pillFillImages ?? <String>[]),
        );

        mergedMap[item.dockno] = newItem;
      }
    }
    final mergedList = mergedMap.values.toList();
    StockUpdateDetails data = stockUpdateDetailObj(inx, mergedList);

    return data;
  }

  StockUpdateDetails stockUpdateDetailObj(index, List<DocketBcSerialList> docketBcSerialList) {
    StockUpdateDetails? stockUpdateDetailsTemp;
    List<StockUpdateDetail> stockUpdateDetailList = [];

    for (var data in docketBcSerialList) {
      if (data.isScan.value) {
        stockUpdateDetailList.add(
          StockUpdateDetail(
            tcno: data.mf,
            dockNo: data.dockno,
            dockSf: data.docksf,
            bkGPkgsno: stockUpdatelist[index].bkgPkgsno == "null" ? 0 : int.parse(stockUpdatelist[index].bkgPkgsno),
            pkgsno: stockUpdatelist[index].bkgPkgsno == "null" ? 0 : totalScan,
            bkGActuwt: stockUpdatelist[index].bkgActuwt == "null" ? 0 : int.parse(stockUpdatelist[index].bkgActuwt),
            actuwt: stockUpdatelist[index].bkgActuwt == "null"
                ? 0
                : pktWeight(int.parse(stockUpdatelist[index].bkgActuwt), int.parse(stockUpdatelist[index].bkgPkgsno)),
            ac: totalScan.toString(),
            wi: "",
            cdelydt: '',
            delyreason: '',
            dp: '1',
            coddodAmount: 0,
            coddodcollected: 0,
            coddod: '',
            isCounterDelivery: false,
            shortageQty: 0,
            shortageWeight: 0,
            shortageReason: '',
            shortageRemarks: '',
            pilferageQty: data.pillFillAgeCount ?? 0,
            pilferageWeight: 0,
            pilferageReason: '',
            pilferageRemarks: '',
            damageQry: data.damageAgeCount ?? 0,
            damageWeight: 0,
            damageReason: '',
            damageRemarks: '',
            isCoddodChar: "",
            delyperson: '',
            pilferageFileName: [
              if (data.isPillFill.value) ...{
                for (var data in data.pillFillImages!) ...{
                  AgeFileName(
                    image: data,
                    mf: '',
                  )
                }
              }
            ],
            damageFileName: [
              if (data.isDamage.value) ...{
                for (var data in data.damageImages!) ...{
                  AgeFileName(
                    image: data,
                    mf: '',
                  ),
                }
              }
            ],
          ),
        );
      }
    }

    stockUpdateDetailsTemp = StockUpdateDetails(
      updateDate: DateFormat('d MMMM yyyy').format(DateTime.now()),
      baseLocationCode: Pref().getBaseLocation(),
      baseUserName: Pref().getUserName(),
      stockUpdateDetails: stockUpdateDetailList,
      bsSerials: bsSerialListTemp,
    );

    return stockUpdateDetailsTemp;
  }

  StockUpdatecheckScan(BuildContext context, String code, bool isQr) {
    bool isContain = docketBcSerialList.any((element) => element.bcSerialNo == code);
    bsScanController.clear();

    if (isContain) {
      if (isQr) {
        Get.back();
      }
      TmsToast.msg('Success');
      for (var data in docketBcSerialList) {
        if (data.bcSerialNo == code) {
          data.isScan.value = true;
        }
      }

      final index = docketBcSerialList.indexWhere((element) => element.bcSerialNo == code);

      BSNumberController.text = docketBcSerialList[index].bcSerialNo;
      Get.to(StockUpdateScannedDocketNumberScreen(
        docketBcSerialList: docketBcSerialList[docketBcSerialList.indexWhere((element) => element.bcSerialNo == code)],
        index: index,
        title: 'Scanned Docket Number',
        onTapText: ' Done ',
        bcNumber: code,
        onTap: () {
          List<DocketBcSerialList> tampList = <DocketBcSerialList>[];
          tampList.add(docketBcSerialList[index]);
          docketBcSerialList.removeAt(index);
          docketBcSerialList.insert(0, tampList[0]);
          tampList.clear();
          Get.back();
        },
        cancelOnTap: () {
          List<DocketBcSerialList> tampList = <DocketBcSerialList>[];
          tampList.add(docketBcSerialList[index]);
          docketBcSerialList.removeAt(index);
          docketBcSerialList.insert(0, tampList[0]);
          tampList.clear();
          Get.back();
        },
        isPreview: false,
      ));
    } else {
      if (isQr) {
        Get.back();
      }
      TmsToast.msg('Please Scan Right Qrcode');
    }
  }

  Future<void> stockUpdateDetails({
    required BuildContext context,
    required int index,
  }) async {
    if (mergeDocketBcSerialList(index).stockUpdateDetails.isEmpty) {
      TmsToast.msg('please scan at-least one number');
    } else {
      AppLoader().show();
      var response = await WebService.tmsPostRequest(
        url: ApiService.stockUpdateDetails,
        body: stockUpdateDetailsToJson(mergeDocketBcSerialList(index)),
      );
      AppLoader().hide();
      try {
        if (response.statusCode == 200) {
          stockUpdateSubmitResponse = stockUpdateSubmitResponseFromJson(response.data);
          if (stockUpdateSubmitResponse.status == 200) {
            submitAlertDialog(
              context: context,
              title: 'Success',
              onTap: () {
                Get.toNamed(AppRoutes.dashboardScreen);
              },
              onTapText: 'Done',
              icon: HugeIcons.strokeRoundedCheckmarkCircle01,
            );
          } else {
            Get.back();
            TmsToast.msg(stockUpdateSubmitResponse.message);
          }
        } else {
          Get.back();
          TmsToast.msg('Stock Update submit ${response.statusMessage}');
        }
      } catch (error) {
        AppLoader().hide();
        TmsToast.msg('Stock update submit error ${error.toString()}');
      }
    }
  }
}
