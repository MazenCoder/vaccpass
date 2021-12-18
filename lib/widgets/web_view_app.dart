import 'package:vaccpass/core/ui/responsive_safe_area.dart';
import 'package:vaccpass/core/util/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';



class WebVewApp extends StatefulWidget {
  final String title;
  final String url;
  const WebVewApp({required this.title, required this.url, Key? key}) : super(key: key);

  @override
  _WebVewAppState createState() => _WebVewAppState();
}

class _WebVewAppState extends State<WebVewApp> {


  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: primaryColor,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
        onWebViewCreated: (controller) {
          _controller ??= controller;
        },
      ),
    );
  }
}

