import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImsWebView(),
    );
  }
}

class ImsWebView extends StatefulWidget {
  const ImsWebView({super.key});

  @override
  State<ImsWebView> createState() => _ImsWebViewState();
}

class _ImsWebViewState extends State<ImsWebView> {
  late final WebViewController controller;

  bool hasInternet = true;
  bool isLoading = true;

  final String url = "https://ims-online.in/welcome";

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() {
              hasInternet = false;
            });
          },
        ),
      );

    checkInternet();

    // ✅ AUTO INTERNET LISTENER (FIXED)
    Connectivity().onConnectivityChanged.listen((result) async {
      final hasNet = result != ConnectivityResult.none;

      if (hasNet) {
        bool realInternet = await hasRealInternet();

        if (realInternet) {
          setState(() {
            hasInternet = true;
          });

          controller.loadRequest(Uri.parse(url));
        }
      } else {
        setState(() {
          hasInternet = false;
        });
      }
    });
  }

  // ✅ REAL INTERNET CHECK
  Future<bool> hasRealInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // ✅ INITIAL CHECK
  Future<void> checkInternet() async {
    bool internet = await hasRealInternet();

    setState(() {
      hasInternet = internet;
    });

    if (internet) {
      controller.loadRequest(Uri.parse(url));
    }
  }

  Future<bool> _onWillPop() async {
    if (hasInternet && await controller.canGoBack()) {
      controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("IMS"),
          backgroundColor: Colors.blue,
          actions: [
            if (hasInternet)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => controller.reload(),
              ),
          ],
        ),
        body: hasInternet
            ? Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        )
            : OfflinePage(
          onRetry: () async {
            bool internet = await hasRealInternet();

            if (internet) {
              setState(() {
                hasInternet = true;
              });

              controller.loadRequest(Uri.parse(url));
            }
          },
        ),
      ),
    );
  }
}