import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera_control/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

class PageCameraControl extends StatelessWidget {
  const PageCameraControl({super.key});

  @override
  Widget build(BuildContext context) {
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    takePhoto() {
      triggerDocRef.update({'takePhoto': true});
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
            TakePhotoButton(onPressed: () => takePhoto()),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
