import 'dart:convert';

import 'package:btcpl/model/login_model/login_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/dash_board_model/location_master.dart';

class PrefId {
  String loginDetails = 'loginDetails';
  String userName = 'userName';
  String locationList = 'locationList';
  String multiLocationList = 'multiLocationList';
  String userPassword = 'userPassword';
  String userId = 'userId';
  String token = 'token';
  String companyCode = 'companyCode';
  String branchCode = 'branchCode';
  String finYear = 'finYear';
  String checkLogin = 'checkLogin';
  String checkHstMode = 'checkHstMode';
  String mfScan = 'mfScan';
  String docketPaketType = 'docketPaketType';
  String printType = 'printType';
  String baseLocation = 'baseLocation';
  String nextLocation = 'nextLocation';
  String checkOutId = 'checkOutId';
  String checkInTime = 'checkInTime';
  String attendanceId = 'attendanceId';
}

class Pref {
  Pref._internal();

  factory Pref() => _singleton;

  static final Pref _singleton = Pref._internal();

  static late SharedPreferences _sharedPreferences;

  void clearPreferencesData() async {
    _sharedPreferences.clear();
  }

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  ///Check user login method
  Future<void> saveIsLogin({required bool value}) async {
    await _sharedPreferences.setBool(PrefId().checkLogin, value);
  }

  bool getIsLogin() => _sharedPreferences.getBool(PrefId().checkLogin) ?? false;

  ///Save user name method
  Future<void> saveUserName({required String val}) async => await _sharedPreferences.setString(PrefId().userName, val);

  String getUserName() => _sharedPreferences.getString(PrefId().userName) ?? '';

  ///Save Location List
  Future<void> saveLocationList({required List<LocationList> val}) async {
    String listEncode = jsonEncode(val);
    await _sharedPreferences.setString(PrefId().locationList, listEncode);
  }

  List<LocationList> getLocationList() {
    String? listDecode = _sharedPreferences.getString(PrefId().locationList);
    if (listDecode == null || listDecode.isEmpty) {
      return [];
    } else {
      List<LocationList> decodedNames = jsonDecode(listDecode);
      return decodedNames;
    }
  }

  ///Save MultiLocation List
  Future<void> saveMultiLocation({required List<MultiLocation> val}) async {
    List<Map<String, dynamic>> jsonList = val.map((e) => e.toJson()).toList();

    String listEncode = jsonEncode(jsonList);

    await _sharedPreferences.setString(PrefId().multiLocationList, listEncode);
  }

  List<MultiLocation> getMultiLocation() {
    String? listDecode = _sharedPreferences.getString(PrefId().multiLocationList);

    if (listDecode == null || listDecode.isEmpty) {
      return [];
    } else {
      List<dynamic> decodedList = jsonDecode(listDecode);
      return decodedList.map((e) => MultiLocation.fromJson(e)).toList();
    }
  }

  ///Save user password method
  Future<void> saveUserPassword({required String val}) async => await _sharedPreferences.setString(PrefId().userPassword, val);

  String getUserPassword() => _sharedPreferences.getString(PrefId().userPassword) ?? '';

  ///Save companyCode method
  Future<void> saveCompanyCode({required String val}) async => await _sharedPreferences.setString(PrefId().companyCode, val);

  String getCompanyCode() => _sharedPreferences.getString(PrefId().companyCode) ?? '';

  ///Save companyCode method
  Future<void> saveBranchCode({required String val}) async => await _sharedPreferences.setString(PrefId().branchCode, val);

  String getBranchCode() => _sharedPreferences.getString(PrefId().branchCode) ?? '';

  ///Save finYear method
  Future<void> saveFinYear({required String val}) async => await _sharedPreferences.setString(PrefId().finYear, val);

  String getFinYear() => _sharedPreferences.getString(PrefId().finYear) ?? '';

  ///Save userId method
  Future<void> saveUserId({required String val}) async => await _sharedPreferences.setString(PrefId().userId, val);

  String getUserId() => _sharedPreferences.getString(PrefId().userId) ?? '';

  ///Save token method
  Future<void> saveToken({required String val}) async => await _sharedPreferences.setString(PrefId().token, val);

  String getToken() => _sharedPreferences.getString(PrefId().token) ?? '';

  ///Save baseLocation method
  Future<void> saveBaseLocation({required String val}) async => await _sharedPreferences.setString(PrefId().baseLocation, val);

  String getBaseLocation() => _sharedPreferences.getString(PrefId().baseLocation) ?? '';

  ///Save nextLocation method
  Future<void> saveNextLocation({required String val}) async => await _sharedPreferences.setString(PrefId().nextLocation, val);

  String getNextLocation() => _sharedPreferences.getString(PrefId().nextLocation) ?? '';

  ///Save checkOutId method
  Future<void> setCheckOutId({required String val}) async => await _sharedPreferences.setString(PrefId().checkOutId, val);

  String getCheckOutId() => _sharedPreferences.getString(PrefId().checkOutId) ?? '';

  ///Save hetMode method
  Future<void> setHstMode({required bool value}) async {
    await _sharedPreferences.setBool(PrefId().checkHstMode, value);
  }

  bool getHstMode() => _sharedPreferences.getBool(PrefId().checkHstMode) ?? false;

  ///Save Docket and paket scan
  Future<void> setMfScan({required bool value}) async {
    await _sharedPreferences.setBool(PrefId().mfScan, value);
  }

  bool getMfScan() => _sharedPreferences.getBool(PrefId().mfScan) ?? false;

  ///Save Docket and paket print
  Future<void> setDocketPaketPrint({required bool value}) async {
    await _sharedPreferences.setBool(PrefId().docketPaketType, value);
  }

  bool getDocketPaketPrint() => _sharedPreferences.getBool(PrefId().docketPaketType) ?? true;

  // ///Save Qr Code and BarCode print
  // Future<void> setPrintType({required bool value}) async {
  //   await _sharedPreferences.setBool(PrefId().printType, value);
  // }
  //
  // bool getPrintType() =>
  //     _sharedPreferences.getBool(PrefId().printType) ?? false;

  ///Save user clock in time
  Future<void> saveClockInTime({required String val}) async => await _sharedPreferences.setString(PrefId().checkInTime, val);

  String getClockInTime() => _sharedPreferences.getString(PrefId().checkInTime) ?? '';

  ///Save user attendance Id
  Future<void> saveAttendanceId({required String val}) async => await _sharedPreferences.setString(PrefId().attendanceId, val);

  String getAttendanceId() => _sharedPreferences.getString(PrefId().attendanceId) ?? '0';

  Future<void> logout() async {
    await _sharedPreferences.clear();
  }
}
