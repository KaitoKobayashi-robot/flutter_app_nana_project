import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';

class ErrorWiFi extends StatelessWidget {
  const ErrorWiFi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Single.height,
      width: Single.width,
      decoration: BoxDecoration(color: ErrorColors.containerColor),
      child: Center(
        child: Text(
          '🛜 Wi-Fiに接続してください 🛜',
          style: TextStyle(
            color: CupertinoColors.systemRed,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
