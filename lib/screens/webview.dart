import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({super.key});

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  WebViewController? _webViewController;

  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('http://10.0.2.2:8080/oauth2/social-login/kakao'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _webViewController!),
    );
  }
}
