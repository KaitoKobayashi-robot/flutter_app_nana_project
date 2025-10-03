import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/button.dart';

class Single {
  static const double width = 430;
  static const double height = 140;
}

class Double {
  static const double width = 320;
  static const double height = 100;
}

Widget singleButtonBuilder(
  String title,
  String subTitle,
  Color boxColor,
  Color textColor,
) {
  return Container(
    width: Single.width,
    height: Single.height,
    decoration: buttonDecoration(boxColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: singleButtonTitleStyle(textColor)),
        Text(subTitle, style: singleButtonSubTitleStyle(textColor)),
      ],
    ),
  );
}

Widget doubleButtonBuilder(
  String title,
  String subTitle,
  Color boxColor,
  Color textColor,
) {
  return Container(
    width: Double.width,
    height: Double.height,
    decoration: buttonDecoration(boxColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: doubleButtonTitleStyle(textColor)),
        Text(subTitle, style: doubleButtonSubTitleStyle(textColor)),
      ],
    ),
  );
}
