import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera_control/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageCameraControl extends StatelessWidget {
  const PageCameraControl({super.key});

  @override
  Widget build(BuildContext context) {
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    takePhoto(BuildContext context) {
      triggerDocRef.update({'takePhoto': true});
      context.push('/camera_waiting');
    }

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Expanded(
              child: Center(
                child: const Text("撮影操作パネル", style: TextStyle(fontSize: 50)),
              ),
            ),
            TakePhotoButton(onPressed: () => takePhoto(context)),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
