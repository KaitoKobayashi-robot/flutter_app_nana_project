import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera_control/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_nana_project/widgets/error.dart';

class PageCameraControl extends StatelessWidget {
  const PageCameraControl({super.key});

  @override
  Widget build(BuildContext context) {
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');
    final resourceDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('resource');

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
            StreamBuilder<DocumentSnapshot>(
              stream: resourceDocRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }
                if (snapshot.hasError) {
                  return ErrorCard(message: 'Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const ErrorCard(message: 'データベースにデータがありません');
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;
                final bool isLocked = data['isLocked'] ?? false;

                if (isLocked) {
                  return TakePhotoButton(onPressed: () => takePhoto(context));
                } else {
                  return ErrorCard(message: 'Webカメラが起動していません');
                }
              },
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
