import 'package:get/get.dart';
import 'drs_controller.dart';


class DRSBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<DRSController>(() => DRSController());
  }
}
