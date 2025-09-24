import 'package:flutter/cupertino.dart';

/* Button Container Design */

BoxShadow buttonShadow = BoxShadow(
  color: CupertinoColors.black.withAlpha(66),
  offset: Offset(0, 10),
  blurRadius: 3,
  blurStyle: BlurStyle.normal,
);

Decoration buttonDecoration(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(70),
    boxShadow: [buttonShadow],
  );
}

/* -------------------------- */

/* Button Text Design */

const double offsetTextSize = 10;
const double singleButtonTextSize = 25;
const double doubleButtonTextSize = 20;

Shadow textShadow = Shadow(
  color: CupertinoColors.black.withAlpha(66),
  offset: Offset(0, 3),
  blurRadius: 3,
);

TextStyle singleButtonTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: singleButtonTextSize,
    fontWeight: FontWeight.bold,
    shadows: [textShadow],
  );
}

TextStyle singleButtonSubTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: singleButtonTextSize - offsetTextSize,
    fontWeight: FontWeight.bold,
    shadows: [textShadow],
  );
}

TextStyle doubleButtonTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: doubleButtonTextSize,
    fontWeight: FontWeight.bold,
    shadows: [textShadow],
  );
}

TextStyle doubleButtonSubTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: doubleButtonTextSize - offsetTextSize,
    fontWeight: FontWeight.bold,
    shadows: [textShadow],
  );
}
