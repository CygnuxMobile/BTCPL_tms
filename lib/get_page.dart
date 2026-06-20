import 'package:btcpl/moduls/drs_generate/drs_generate_binding.dart';
import 'package:btcpl/moduls/drs_generate/drs_generate_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import 'moduls/arrival_page/arrival_binding.dart';
import 'moduls/arrival_page/arrival_screen.dart';
import 'moduls/attendance_page/attendance_binding.dart';
import 'moduls/attendance_page/attendance_screen.dart';
import 'moduls/docket_page/docket_binding.dart';
import 'moduls/docket_page/docket_package_list.dart';
import 'moduls/docket_page/docket_screen.dart';
import 'moduls/drs_page/docket_list/docket_list_screen.dart';
import 'moduls/drs_page/drs_binding.dart';
import 'moduls/drs_page/drs_list_screen.dart';
import 'moduls/drs_page/drs_update/drs_update_screen.dart';
import 'moduls/home_page/dash_board_binding.dart';
import 'moduls/home_page/dash_board_screen.dart';
import 'moduls/login_page/login_screen.dart';
import 'moduls/login_page/login_screen_binding.dart';
import 'moduls/manifest_page/manifest_bindings.dart';
import 'moduls/manifest_page/manifest_screen.dart';
import 'moduls/pod_page/pod_screen.dart';
import 'moduls/qr_page/qr_scan_bindings.dart';
import 'moduls/qr_page/qr_scan_screen.dart';
import 'moduls/quick_docket_page/quick_docket_binding.dart';
import 'moduls/quick_docket_page/quick_docket_screen.dart';
import 'moduls/splash_page/splash_screen.dart';
import 'moduls/splash_page/splash_screen_bindings.dart';
import 'moduls/stock_update_page/stock_update_binding.dart';
import 'moduls/stock_update_page/stock_update_list/stock_update_list_screen.dart';
import 'moduls/stock_update_page/stock_update_screen.dart';
import 'moduls/trecking_page/tracking_bindings.dart';
import 'moduls/trecking_page/tracking_screen.dart';
import 'moduls/unloading_page/unloading_screen.dart';
import 'moduls/unloading_page/unloading_screen_bindings.dart';

List<GetPage> getPages = [
  GetPage(
    name: AppRoutes.rootPage,
    page: () => SplashScreen(),
    binding: SplashScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.loginScreen,
    page: () => LoginScreen(),
    binding: LoginScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.dashboardScreen,
    page: () => const DashBordScreen(),
    binding: DashBoardBinding(),
  ),
  GetPage(
    name: AppRoutes.docketDetails,
    page: () => DocketScreen(),
    binding: DocketBinding(),
  ),
  GetPage(
    name: AppRoutes.manifestScreen,
    page: () => ManifestScreen(),
    binding: ManifestBinding(),
  ),
  GetPage(
    name: AppRoutes.qRScanScreen,
    page: () => QrScanScreen(),
    binding: QrScanBinding(),
  ),
  GetPage(
    name: AppRoutes.arrivalScreen,
    page: () => ArrivalScreen(),
    binding: ArrivalBinding(),
  ),
  GetPage(
    name: AppRoutes.docketPackageScreen,
    page: () => DocketPackageScreen(),
  ),
  GetPage(
    name: AppRoutes.podScreen,
    page: () => PodUploadScreen(),
  ),
  GetPage(
    name: AppRoutes.unloadingScreen,
    page: () => UnloadingScreen(),
    binding: UnloadingScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.attendanceScreen,
    page: () => const AttendanceScreen(),
    binding: AttendanceBinding(),
  ),
  GetPage(
    name: AppRoutes.treckingScreen,
    page: () => const TrackingScreen(),
    binding: TrackingBinding(),
  ),
  GetPage(
    name: AppRoutes.stockUpdateScreen,
    page: () => const StockUpdate(),
    binding: StockUpdateBinding(),
  ),
  GetPage(
    name: AppRoutes.stockUpdateListScreen,
    page: () => StockUpdateListScreen(),
  ),
  GetPage(
    name: AppRoutes.drsListScreen,
    page: () => const DRSListScreen(),
    binding: DRSBinding(),
  ),
  GetPage(
    name: AppRoutes.docketListScreen,
    page: () => const DocketListScreen(),
  ),
  GetPage(
    name: AppRoutes.drsUpdateScreen,
    page: () => DrsUpdateScreen(),
  ),
  GetPage(
    name: AppRoutes.drsGenerateScreen,
    page: () => DRSGenerateScreen(),
    binding: DRSGenerateBinding(),
  ),
  GetPage(
    name: AppRoutes.quickDocketScreen,
    page: () => const QuickDocketScreen(),
    binding: QuickDocketBinding(),
  ),
];
