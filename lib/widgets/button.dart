import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/button.dart';

Widget singleButtonBuilder(
  String title,
  String subTitle,
  Color boxColor,
  Color textColor,
) {
  return Container(
    width: 430,
    height: 140,
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
    width: 320,
    height: 100,
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
