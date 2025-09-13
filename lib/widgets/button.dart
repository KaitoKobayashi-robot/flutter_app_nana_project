import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/button.dart';

Widget singleButtonBuilder(String title, String subTytle, Color color) {
  return Container(
    width: 430,
    height: 140,
    decoration: singleButtonDecoration(color),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: singleButtonTitleStyle),
        Text(subTytle, style: singleButtonSubTytleStyle),
      ],
    ),
  );
}
