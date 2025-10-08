import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/start/widgets/cards.dart';
import 'package:flutter_app_nana_project/widgets/error.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

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
          children: [
            const SizedBox(height: 100),
            Logo(height: 150),
            const Expanded(child: Center(child: Cards())),
            // Wi-Fiに接続されている場合
            if (_isWifiConnected)
              SingleButton(onPressed: () => push(context))
            // Wi-Fiに接続されていない場合
            else
              const ErrorCard(message: '🛜 Wi-Fiに接続してください 🛜'),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
