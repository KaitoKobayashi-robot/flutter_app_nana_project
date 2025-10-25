import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/camera_graphic.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';

class PageCamera extends StatelessWidget {
  PageCamera({super.key});

  final triggerDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('trigger');

  push(BuildContext context) {
    triggerDocRef.update({'takePhoto': true});
    context.push('/camera_waiting');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            Logo(),
            Expanded(child: Center(child: CameraGraphic())),
            Container(
              alignment: Alignment.center,
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
