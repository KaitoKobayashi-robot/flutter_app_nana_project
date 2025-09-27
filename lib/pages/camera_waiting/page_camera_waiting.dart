import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        if (data['takePhoto'] == false) {
          // takePhotoがfalseになったらcamera_previewに遷移
          context.pushReplacement('/camera_preview');
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
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
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
