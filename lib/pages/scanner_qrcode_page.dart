import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vaccpass/core/usecases/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vaccpass/covid_pass.dart';
import 'package:vaccpass/did_client.dart';
import 'package:vaccpass/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';



class ScannerQrcodePage extends StatefulWidget {
  const ScannerQrcodePage({Key? key}) : super(key: key);

  @override
  _ScannerQrcodePageState createState() => _ScannerQrcodePageState();
}

class _ScannerQrcodePageState extends State<ScannerQrcodePage> {
  static const bool allowTestIssuers = false;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final DidClient didClient = DidClient();
  Barcode? result;
  QRViewController? controller;
  CovidPass? covidPass;
  String? errorMessage;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: covidPass != null
                ? ValidCovidPassCard(covidPass: covidPass!)
                : errorMessage != null
                ? CovidPassErrorCard(error: errorMessage!)
                : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MdiIcons.qrcode),
                    SizedBox(width: 4,),
                    Text('Scanning..'),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      CovidPass? pass;
      String? error;
      if (scanData.code != null) {
        try {
          pass = await CovidPass.parse(scanData.code!,
              didClient: didClient, allowTestIssuers: allowTestIssuers);
          if (pass != null) {
            await appUtils.saveScanQrcode(pass);
          }
        } on CovidPassException catch (e) {
          error = e.cause.toString();
        } on CoseException catch (e) {
          error = e.cause.toString();
        }
      }

      setState(() {
        covidPass = pass;
        errorMessage = error;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ValidCovidPassCard extends StatelessWidget {
  final CovidPass covidPass;

  const ValidCovidPassCard({Key? key, required this.covidPass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_box_rounded, color: Colors.green, size: 60),
            Text('VALID PASS',
              style: TextStyle(fontSize: 10, color: Colors.green),
            ),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(covidPass.givenName??'',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(covidPass.familyName ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (covidPass.dob != null)
              Text(DateFormat('dd MMM yyyy').format(covidPass.dob!)),
          ],
        ),
      ],
    );
  }
}

class CovidPassErrorCard extends StatelessWidget {
  final String error;

  const CovidPassErrorCard({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.cancel_rounded, color: Colors.red, size: 60),
              Text('ERROR', style: TextStyle(fontSize: 10, color: Colors.red)),
            ],
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(friendlyMessage(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  String friendlyMessage() {
    switch (error) {
      case "CovidPassErrorCode.invalidUrl":
        return "This is not a NZ COVID Pass code.";
      case "CovidPassErrorCode.invalidIssuer":
        return "This is not from a valid pass issuer.";
      case "CovidPassErrorCode.expired":
        return "This NZ COVID Pass is expired.";
      case "CovidPassErrorCode.notYetValid":
        return "This NZ COVID Pass is not valid yet.";
      case "CovidPassErrorCode.networkError":
        return "There was a problem connecting to the Internet to verify this pass.";
      default:
        return "This is a NZ COVID Pass code but it is invalid.";
    }
  }
}