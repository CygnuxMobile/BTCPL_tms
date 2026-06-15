import 'package:btcpl/moduls/stock_update_page/stock_update_controller.dart';
import 'package:get/get.dart';

class StockUpdateBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<StockUpdateController>(() => StockUpdateController());
  }
}
