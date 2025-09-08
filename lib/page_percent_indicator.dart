import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/PercentIndicatorProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:go_router/go_router.dart';

class PagePercentIndicator extends ConsumerStatefulWidget {
  const PagePercentIndicator({super.key});

  @override
  ConsumerState<PagePercentIndicator> createState() =>
      _PageprecentIndicatorState();
}

class _PageprecentIndicatorState extends ConsumerState<PagePercentIndicator> {
  @override
  void initState() {
    super.initState();
    ref.read(percentProvider.notifier).startIndicator();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<double>(percentProvider, (previous, next) {
      if (next >= 1.0) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted) {
            ref.invalidate(percentProvider);
            context.push('/camera_preview');
          }
        });
      }
    });

    final percent = ref.watch(percentProvider);

    final circular = CircularPercentIndicator(
      percent: percent,
      backgroundColor: CupertinoColors.inactiveGray,
      progressColor: Color.fromARGB(255, 253, 141, 255),
      radius: 100.0,
      lineWidth: 20,
      center: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${percent * 100}%',
              style: TextStyle(
                color: Color.fromARGB(255, 253, 141, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'COMPLETED',
              style: TextStyle(
                color: Color.fromARGB(255, 253, 141, 255),
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
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(child: circular),
    );
  }
}
