import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/fonts_sizes.dart';

class NewsDetails extends StatefulWidget {
  final String url;
  final String headLine;
  const NewsDetails({super.key, required this.url, required this.headLine});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  int loadingPercentage = 0;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if(mounted){
              setState(() {
                loadingPercentage = progress;
              });
            }
          },
          onPageStarted: (String url) {
            if(mounted){
              setState(() {
                loadingPercentage = 0;
              });
            }
          },
          onPageFinished: (String url) {
            if(mounted){
              setState(() {
                loadingPercentage = 100;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.headLine,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        titleTextStyle: Fonts.fontRobot(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.titleColor),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
