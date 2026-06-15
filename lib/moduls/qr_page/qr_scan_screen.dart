import 'dart:developer';

import 'package:btcpl/moduls/qr_page/qr_scan_ontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../widgets/app_size.dart';
import '../../widgets/tms_normaltext.dart';

class QrScanScreen extends StatefulWidget {
  QrScanScreen({Key? key}) : super(key: key);

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  QrScanController ctrl = Get.find<QrScanController>();

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
          title: const TmsText(
            text: 'QRScan',
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffFAFAFA),
          elevation: 0,
        ),
        body: QRView(
          key: ctrl.qrKey,
          onQRViewCreated: (p0) => ctrl.onQRViewCreated(p0, context),
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 05,
            borderLength: 20,
            borderWidth: 05,
            cutOutHeight: AppSize.size(context).height * 0.30,
            cutOutWidth: double.infinity,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }
}

void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  if (!p) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('no Permission')),
    );
  }
}
