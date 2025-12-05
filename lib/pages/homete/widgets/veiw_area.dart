import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:lottie/lottie.dart';

class VeiwArea extends StatelessWidget {
  const VeiwArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "雨の日に私を迎えに来てくれた母",
          style: TextStyle(
            color: MainColors.black,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
        Lottie.asset("assets/json/start_page/mother.json"),
      ],
    );
  }
}
