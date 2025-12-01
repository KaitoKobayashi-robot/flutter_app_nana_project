import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/terms/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/terms/widgets/terms.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/back_button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class PageTerms extends StatelessWidget {
  const PageTerms({super.key});

  push(BuildContext context) {
    context.push('/theme');
  }

  back(BuildContext context) {
    context.go('/start');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: Logo(),
                ),
                Terms(),
                Expanded(child: Container()),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: ButtonArea.width,
                  height: ButtonArea.height,
                  child: SingleButton(onPressed: () => push(context)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 500,
            left: -155,
            child: Transform.rotate(
              angle: 270 * pi / 180,
              child: Lottie.asset("assets/json/boat.json", height: 50),
            ),
          ),
          Positioned(
            top: 50,
            left: 50,
            child: BackButton(onPressed: () => back(context)),
          ),
        ],
      ),
    );
  }
}
