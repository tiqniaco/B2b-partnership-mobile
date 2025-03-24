import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsWebview extends StatefulWidget {
  const TermsAndConditionsWebview({super.key});

  @override
  TermsAndConditionsWebviewState createState() =>
      TermsAndConditionsWebviewState();
}

class TermsAndConditionsWebviewState extends State<TermsAndConditionsWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "https://b2bpartnership.com/%d9%85%d9%86-%d9%86%d8%ad%d9%86/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("عرض صفحة ويب")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
