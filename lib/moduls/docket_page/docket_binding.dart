import 'package:get/get.dart';
import 'docket_controller.dart';



class DocketBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<DocketController>(() => DocketController());
  }
}

