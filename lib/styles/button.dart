import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

/* Button Container Design */

Decoration buttonDecoration(Color color) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: 5, color: MainColors.white),
    borderRadius: BorderRadius.circular(20),
  );
}

Decoration buttonDoubleDecoration(Color color) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: 5, color: MainColors.white),
    borderRadius: BorderRadius.circular(15),
  );
}

/* -------------------------- */

/* Button Text Design */

const double offsetSingleTextSize = 10;
const double offsetDoubleTextSize = 5;
const double singleButtonTextSize = 45;
const double doubleButtonTextSize = 30;

TextStyle singleButtonTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: singleButtonTextSize,
    fontWeight: FontWeight.bold,
    height: 1.0,
  );
}

TextStyle singleButtonSubTitleStyle(Color color) {
  return TextStyle(
    fontFamily: 'ZenMaruGothic',
    color: color,
    fontSize: singleButtonTextSize - offsetSingleTextSize,
    fontWeight: FontWeight.bold,
    height: 1.0,
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
    fontSize: doubleButtonTextSize - offsetDoubleTextSize,
    fontWeight: FontWeight.bold,
    height: 1.0,
  );
}
