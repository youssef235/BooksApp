import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Widgets/appBar.dart';

class BookReaderScreen extends StatelessWidget {
  final String? bookUrl;

  BookReaderScreen({required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar().buildappBar(context, "Let's read"),
      body: WebView(
        initialUrl: bookUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
