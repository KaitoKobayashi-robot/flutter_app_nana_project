import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

/* Button Container Design */

Decoration buttonDecoration(Color color) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: 3, color: MainColors.white),
    borderRadius: BorderRadius.circular(20),
  );
}

/* -------------------------- */

/* Button Text Design */

const double offsetTextSize = 10;
const double singleButtonTextSize = 35;
const double doubleButtonTextSize = 20;

TextStyle singleButtonTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: singleButtonTextSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle singleButtonSubTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: singleButtonTextSize - offsetTextSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle doubleButtonTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: doubleButtonTextSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle doubleButtonSubTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: doubleButtonTextSize - offsetTextSize,
    fontWeight: FontWeight.bold,
  );
}
