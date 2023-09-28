import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quickyshop/services/retentionsService.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/utils/Colors.dart';

class QRViewScreen extends StatefulWidget {
  const QRViewScreen({super.key});

  @override
  State<QRViewScreen> createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  TextEditingController scannedCode = TextEditingController(text: "QR Code");
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  RetentionService _retentionService = RetentionService();
  SurveyService _surveyService = SurveyService();

  late String qrScanned;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: buildQrView(context)),
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400
        ? 480.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (control, p) => onPermissionSet(context, control, p),
    );
  }

  void onPermissionSet(
      BuildContext context, QRViewController controller, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No permisson')));
    }
  }

  Future<void> onQRViewCreated(QRViewController controller) async {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      qrController!.pauseCamera();
      RetentionResponse retentionResponse =
          await _retentionService.searchRetention(scanData.code!);

      if (retentionResponse.data != null) {
        await _surveyService.uploadResponse(retentionResponse.data);
        // const snackBar = SnackBar(
        //   content: Text('Encontrado'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await _retentionService.deleteRetention(scanData.code!);
      } else {
        // const snackBar = SnackBar(
        //   content: Text('No se ha encontrado el recurso.'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, onDone: () async {
      print('terminado');
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    scannedCode.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
