import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends StatelessWidget {

  static void show({Key? key}) {
    showDialog<void>(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(key: key),
    );
  }

  static void hide() {
    Navigator.pop(Get.overlayContext!,);
  }

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
