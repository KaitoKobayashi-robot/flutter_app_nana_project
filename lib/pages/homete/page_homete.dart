import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/homete/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/homete/widgets/veiw_area.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageHomete extends StatelessWidget {
  const PageHomete({super.key});

  push(BuildContext context) {
    context.push('/start');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HometeButton(onPressed: () => push(context)),
            VeiwArea(),
          ],
        ),
      ),
    );
  }
}
