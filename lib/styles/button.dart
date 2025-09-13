import 'package:flutter/cupertino.dart';

Decoration singleButtonDecoration(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(70),
    boxShadow: [
      BoxShadow(
        color: CupertinoColors.black.withAlpha(66),
        offset: Offset(0, 10),
        blurRadius: 3,
        blurStyle: BlurStyle.normal,
      ),
    ],
  );
}

TextStyle singleButtonTitleStyle = TextStyle(
  color: CupertinoColors.white,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      color: CupertinoColors.black.withAlpha(66),
      offset: Offset(0, 3),
      blurRadius: 3,
    ),
  ],
);

TextStyle singleButtonSubTytleStyle = TextStyle(
  color: CupertinoColors.white,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      color: CupertinoColors.black.withAlpha(66),
      offset: Offset(0, 3),
      blurRadius: 3,
    ),
  ],
);
