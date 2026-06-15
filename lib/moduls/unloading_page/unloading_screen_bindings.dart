import 'package:btcpl/moduls/unloading_page/unloading_screen_controller.dart';
import 'package:get/get.dart';

class UnloadingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnloadingScreenController>(() => UnloadingScreenController());
  }
}
