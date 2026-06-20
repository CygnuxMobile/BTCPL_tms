import 'package:get/get.dart';
import 'drs_generate_controller.dart';

class DRSGenerateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DRSGenerateController>(
      () => DRSGenerateController(),
    );
  }
}
