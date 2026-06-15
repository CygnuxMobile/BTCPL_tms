import 'package:btcpl/moduls/pod_page/pod_controller.dart';
import 'package:get/get.dart';

class PodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodUploadController>(() => PodUploadController());
  }
}
