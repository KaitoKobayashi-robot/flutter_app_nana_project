import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageCameraWaiting extends StatefulWidget {
  const PageCameraWaiting({super.key});

  @override
  State<PageCameraWaiting> createState() => _PageCameraWaitingState();
}

class _PageCameraWaitingState extends State<PageCameraWaiting> {
  late StreamSubscription<DocumentSnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    _subscription = triggerDocRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        // takePhotoがfalseになり、かつlatestImageNameが存在する場合に遷移
        if (data['takePhoto'] == false && data['latestImageName'] != null) {
          final imageName = data['latestImageName'] as String;
          if (mounted) {
            // extraにファイル名を渡して画面遷移
            context.pushReplacement('/camera_preview', extra: imageName);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 40),
            SizedBox(height: 40),
            Text(
              '撮影中です...',
              style: TextStyle(fontSize: 24, color: CupertinoColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
