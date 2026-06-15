import 'package:btcpl/moduls/trecking_page/tracking_controller.dart';
import 'package:get/get.dart';
class TrackingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TrackingController>(() => TrackingController());
  }
}
