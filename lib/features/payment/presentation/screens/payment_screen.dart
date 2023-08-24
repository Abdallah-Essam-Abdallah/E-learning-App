import 'dart:async';
import 'dart:io';
import 'package:courses_app/features/payment/presentation/controller/payment_bloc/payment_bloc.dart';
import 'package:courses_app/features/payment/presentation/screens/payment_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/core/dependency_injection/injection.dart' as di;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.course}) : super(key: key);
  final String course;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () async {
              di
                  .getIt<PaymentBloc>()
                  .add(AddCourseToBookedCoursesEvent(course: widget.course));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const PaymentConfirmation())));
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ]),
        body: WebView(
          initialUrl:
              'https://accept.paymob.com/api/acceptance/iframes/770308?payment_token=${PaymentBloc.lastToken}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
