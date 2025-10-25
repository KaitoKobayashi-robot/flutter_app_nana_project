import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/providers/percent_indicator_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

progressIndicatorBuilder(BuildContext context, WidgetRef ref) {
  return Center(
    child: CircularPercentIndicator(
      percent: ref.watch(uploadProgressProvider),
      backgroundColor: MainColors.white,
      progressColor: MainColors.mainColor,
      radius: 200.0,
      lineWidth: 30,
      center: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(ref.watch(uploadProgressProvider) * 100).toInt()}%',
              style: TextStyle(
                fontFamily: "ZenMaruGothic",
                fontSize: 30,
                color: MainColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'COMPLETED',
              style: TextStyle(
                fontSize: 30,
                color: MainColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      animation: true,
      animationDuration: 500,
      animateFromLastPercent: true,
      circularStrokeCap: CircularStrokeCap.round,
    ),
  );
}
