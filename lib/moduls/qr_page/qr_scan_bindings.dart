import 'package:btcpl/moduls/qr_page/qr_scan_ontroller.dart';
import 'package:get/get.dart';

class QrScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrScanController>(() => QrScanController());
  }
}
