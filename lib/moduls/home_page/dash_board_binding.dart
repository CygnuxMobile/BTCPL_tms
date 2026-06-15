import 'package:get/get.dart';

import 'dash_board_controller.dart';

class DashBoardBinding extends Bindings {


  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}
