import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/camera_graphic.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/error.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';

class PageCamera extends StatelessWidget {
  PageCamera({super.key});

  final triggerDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('trigger');
  final resourceDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('resource');

  push(BuildContext context) {
    triggerDocRef.update({'showCamera': true});
    context.push('/camera_control');
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
            Expanded(child: Center(child: CameraGraphic())),
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
                  return SingleButton(onPressed: () => push(context));
                } else {
                  return ErrorCard(message: 'Webカメラが起動していません');
                }
              },
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
