import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  WebViewController? webViewController;
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('In Progress $progress' as num);
          },
          onPageStarted: (String url) {
            log("The started Page: $url" as num);
          },
          onPageFinished: (String url) {
            log("The finished Page: $url" as num);
          },
          onWebResourceError: (WebResourceError error) {
            log("There is some Error loading th page" as num);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("facebook")) {
              log("Navigation not valid" as num);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse("https://app.akila.store"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Akila Eshop",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: webViewController!,
        ),
      ),
    );
  }
}
