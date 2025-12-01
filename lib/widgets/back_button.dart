import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        width: 130,
        height: 60,
        decoration: BoxDecoration(
          color: MainColors.black,
          border: Border.all(width: 5, color: MainColors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              "最初に戻る",
              style: TextStyle(
                fontFamily: 'ZenMaruGothic',
                color: MainColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Back",
              style: TextStyle(
                fontFamily: 'ZenMaruGothic',
                color: MainColors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
