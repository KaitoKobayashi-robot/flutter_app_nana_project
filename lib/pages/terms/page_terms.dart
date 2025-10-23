import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/terms/widgets/button.dart';
import 'package:flutter_app_nana_project/pages/terms/widgets/terms.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';

class PageTerms extends StatelessWidget {
  const PageTerms({super.key});

  push(BuildContext context) {
    context.push('/theme');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: Logo(),
            ),
            Terms(),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.bottomCenter,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: SingleButton(onPressed: () => push(context)),
            ),
          ],
        ),
      ),
    );
  }
}
