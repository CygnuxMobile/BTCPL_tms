import 'package:btcpl/moduls/quick_docket_page/quick_docket_controller.dart';
import 'package:get/get.dart';

class QuickDocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickDocketController>(() => QuickDocketController());
  }
}
