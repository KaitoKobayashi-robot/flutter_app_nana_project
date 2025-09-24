import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/page_start/styles/colors.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  cardBuilder(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      width: 600,
      decoration: BoxDecoration(
        color: CardColors.bgColor,
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text("手順 $index")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return cardBuilder(index + 1);
        }),
      ),
    );
  }
}
