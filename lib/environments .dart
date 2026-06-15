enum Environments { btcpl }

abstract class AppEnvironments {
  static late String baseurl;
  static late String title;
  static late String version;
  static late Environments environments;
  static List<String> dashBordList = <String>[];

  static Environments get _environments => environments;

  ///this method is change flavor
  static setupEvm(Environments evm) {
    environments = evm;
    title = "BTCPL";

    baseurl = "http://43.248.56.36:8080/"; //bhor

    version = 'v 03.06.26';
    dashBordList = [
      'quickDocket',
      'gcn',
      'manifest',
      'arrival',
      'stockUpdate',
      'pod',
      'unloadingSheet',
      'attendance',
      'tracking',
      'drs',
      'prq'
    ];
  }
}
