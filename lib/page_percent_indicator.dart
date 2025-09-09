import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/PercentIndicatorProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

progressIndicatorBuilder(BuildContext context, WidgetRef ref) {
  return Center(
    child: CircularPercentIndicator(
      percent: ref.watch(uploadProgressProvider),
      backgroundColor: CupertinoColors.inactiveGray,
      progressColor: Color.fromARGB(255, 253, 141, 255),
      radius: 200.0,
      lineWidth: 30,
      center: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(ref.watch(uploadProgressProvider) * 100).toInt()}%',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 253, 141, 255),
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'COMPLETED',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 253, 141, 255),
                // fontWeight: FontWeight.bold,
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
