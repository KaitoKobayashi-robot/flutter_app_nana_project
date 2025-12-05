import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/camera_graphic.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/back_button.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';

class PageCamera extends StatelessWidget {
  PageCamera({super.key});

  final triggerDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('trigger');

  Future<void> push(BuildContext context) async {
    try {
      await triggerDocRef.set({'takePhoto': true}, SetOptions(merge: true));
      if (context.mounted) {
        context.push('/camera_waiting');
      }
    } catch (e) {
      log("Error in push to camera waiting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Stack(
        children: [
          Center(
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
          Positioned(top: 50, left: 50, child: BackButton()),
        ],
      ),
    );
  }
}
