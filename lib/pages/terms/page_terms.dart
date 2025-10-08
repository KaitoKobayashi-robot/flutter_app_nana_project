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
            SizedBox(height: 70),
            Logo(height: 100),
            SizedBox(height: 50),
            Expanded(child: Terms()),
            Container(
              alignment: Alignment.center,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: SingleButton(onPressed: () => push(context)),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
