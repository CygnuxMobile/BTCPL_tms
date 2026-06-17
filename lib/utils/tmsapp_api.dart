

import '../environments .dart';

class ApiService {
  ///baseurl
  static String baseUrl = AppEnvironments.baseurl;

  ///subUrl
  static String login = '${baseUrl}V1/Authenticate/Login';
  static String getLocationMasterData = '${baseUrl}V1/Master/GetLocationMasterData';
  static String getBarCodePrintByGCN = '${baseUrl}V1/Operation/GetBarCodePrintByGCN';
  static String checkValidSerialNo = '${baseUrl}V1/Operation/CheckValidSerialNo';
  static String prepareManifest = '${baseUrl}V1/Operation/PrepareManifest';
  static String thcArrivalSubmit = '${baseUrl}V1/Operation/THCArrivalSubmit';
  static String thcArrivalsList = '${baseUrl}V1/Operation/THCArrivalsList';
  static String getUnloadingSheetData = '${baseUrl}V1/Operation/GetUnloadingSheetData';
  static String getPodList = '${baseUrl}V1/Operation/GetPODlist';
  static String uploadPODImage = '${baseUrl}V1/Operation/UploadPODImage';
  static String attendance = '${baseUrl}V1/Master/AttandanceClockIn';
  static String getAttendance = '${baseUrl}V1/Master/GetAttendance';
  static String stockUpdateList = '${baseUrl}V1/Operation/StockUpdateList';
  static String stockUpdateDetails = '${baseUrl}V1/Operation/StockUpdateDetails';
  static String trackingDetails = '${baseUrl}V1/Operation/DocketTracking';
  static String dRSUpdateList = '${baseUrl}V1/Operation/DRSUpdateList';
  static String updateDRSDetails = '${baseUrl}V1/Operation/UpdateDRSDetails';
  static String getGeneralMasterData = '${baseUrl}V1/Operation/GetGeneralMasterData';
  static String updateDRS = '${baseUrl}V1/Operation/UpdateDRS';
  static String checkValidDocketNo = '${baseUrl}V1/Operation/CheckValidDocketNo';
  static String quickDocketAPI = '${baseUrl}V1/Operation/QuickDocketAPI';
  static String cityAPI = '${baseUrl}V1/Operation/GetAllCityList';
  static String getVendorType = '${baseUrl}V1/Operation/GetVendorType';
  static String getVendorsFromVendorType = '${baseUrl}V1/Operation/GetVendorsFromVendorType';
  static String getVehicleFromVendor = '${baseUrl}V1/Operation/GetVehicleFromVendor';
  static String getVehicleDetails = '${baseUrl}V1/Operation/GetVehicleDetails';
  static String getDriverList = '${baseUrl}V1/Operation/GetDriverList';
  static String getDriverDetails = '${baseUrl}V1/Operation/GetDriverDetails';
  static String getDeliveryAgent = '${baseUrl}V1/Operation/GetDeliveryAgent';
  static String getCrossingAgent = '${baseUrl}V1/Operation/GetCrossingAgent';
  static String avalabledocketinPRSDRS = '${baseUrl}V1/Operation/AvalabledocketinPRSDRS';
  static String prepareDRS = '${baseUrl}V1/Operation/PrepareDRS';
}
