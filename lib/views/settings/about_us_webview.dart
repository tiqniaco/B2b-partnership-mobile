import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsWebview extends StatefulWidget {
  const AboutUsWebview({super.key});

  @override
  AboutUsWebviewState createState() => AboutUsWebviewState();
}

class AboutUsWebviewState extends State<AboutUsWebview> {
  late final WebViewController _controller;
  bool isLoading = true; // متغير لمعرفة حالة التحميل

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false; // الصفحة انتهت من التحميل
            });
            // تعطيل جميع الروابط والأزرار بعد تحميل الصفحة بالكامل
            _controller.runJavaScript("""
              document.querySelectorAll('a, button, input').forEach(el => {
                el.style.pointerEvents = 'none';  // منع النقر
                el.style.opacity = '0.6';  // تقليل وضوح العناصر
              });
            """);
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "https://b2bpartnership.com/%d9%85%d9%86-%d9%86%d8%ad%d9%86/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us".tr),
        backgroundColor: whiteColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: WebViewWidget(controller: _controller),
            ),
            if (isLoading) // عرض مؤشر تحميل أثناء تحميل الصفحة
              Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
