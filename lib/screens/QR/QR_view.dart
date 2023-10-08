import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quickyshop/services/retentionsService.dart';
import 'package:quickyshop/services/surveyService.dart';
import 'package:quickyshop/utils/Colors.dart';
import 'package:quickyshop/widgets/buttons/quickyButton.dart';
import 'package:quickyshop/widgets/dialogs/QuickyAlertDialog.dart';

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
        // child: Container(
        //   height: MediaQuery.of(context).size.height * 0.60,
        //   width: MediaQuery.of(context).size.width,
        //   child: Column(
        //     children: [buildQrView(context)],
        //   ),
        // ),

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  child: buildQrView(context),
                ),
                SizedBox(height: 50),
                QuickyButton(
                    type: QuickyButtonTypes.primary,
                    child: Text('Tomar otra vez'),
                    onTap: () {
                      qrController!.resumeCamera();
                    })
              ],
            ),
          ),
        ),
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
      print(scanData.code);
      qrController!.pauseCamera();
      RetentionResponse retentionResponse =
          await _retentionService.searchRetention(scanData.code!);

      if (retentionResponse.data != null) {
        await _surveyService.uploadResponse(retentionResponse.data);

        await _retentionService.deleteRetention(scanData.code!);

        showDialog(
            context: context,
            builder: (context) {
              return QuickyAlertDialog(
                size: 'approved-coupon',
                childContent: Column(
                  children: [
                    Image(
                        height: 40,
                        image: AssetImage('assets/icons/usability/done.png')),
                    SizedBox(height: 12),
                    Text('Aprobada',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800))
                  ],
                ),
              );
            });
      } else {
        // const snackBar = SnackBar(
        //   content: Text('No se ha encontrado el recurso.'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        showDialog(
            context: context,
            builder: (context) {
              return QuickyAlertDialog(
                size: 'error-coupon',
                childContent: Column(
                  children: [
                    Text('Lo sentimos!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                    SizedBox(height: 12),
                    Image(
                        height: 40,
                        image:
                            AssetImage('assets/icons/usability/close_red.png')),
                    SizedBox(height: 12),
                    Text('Denegada',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800))
                  ],
                ),
              );
            });
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
