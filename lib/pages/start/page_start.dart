import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter_app_nana_project/pages/start/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/cards.dart';
import 'package:flutter_app_nana_project/widgets/error.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';

class PageStart extends StatefulWidget {
  const PageStart({super.key});

  @override
  State<PageStart> createState() => _PageStartState();
}

class _PageStartState extends State<PageStart> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isWifiConnected = true;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _isWifiConnected = result.contains(ConnectivityResult.wifi);
    });
  }

  void push(BuildContext context) {
    context.push('/terms');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 30),
              child: Logo(height: 140),
            ),
            Expanded(child: Center(child: Cards())),
            Container(
              alignment: Alignment.bottomCenter,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: _isWifiConnected
                  ? SingleButton(onPressed: () => push(context))
                  : const ErrorCard(message: '🛜 Wi-Fiに接続してください 🛜'),
            ),
          ],
        ),
      ),
    );
  }
}
