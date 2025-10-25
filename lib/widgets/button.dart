import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/button.dart';

class Single {
  static const double width = 500;
  static const double height = 130;
}

class Double {
  static const double width = 320;
  static const double height = 130;
}

class ButtonArea {
  static const double width = double.infinity;
  static const double height = 230;
  static const double spacing = 20;
}

Widget singleButtonBuilder(
  String title,
  String subTitle,
  Color boxColor,
  Color textColor,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
    width: Single.width,
    height: Single.height,
    decoration: buttonDecoration(boxColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: singleButtonTitleStyle(textColor)),
        Text(subTitle, style: singleButtonSubTitleStyle(textColor)),
        SizedBox(height: 10),
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
    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
    width: Double.width,
    height: Double.height,
    decoration: buttonDoubleDecoration(boxColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: doubleButtonTitleStyle(textColor)),
        Text(subTitle, style: doubleButtonSubTitleStyle(textColor)),
      ],
    ),
  );
}
