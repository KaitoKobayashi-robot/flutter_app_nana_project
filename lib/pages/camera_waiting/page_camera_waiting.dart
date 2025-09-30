import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/providers/user_image_provider.dart';

class PageCameraWaiting extends ConsumerStatefulWidget {
  const PageCameraWaiting({super.key});

  @override
  ConsumerState<PageCameraWaiting> createState() => _PageCameraWaitingState();
}

class _PageCameraWaitingState extends ConsumerState<PageCameraWaiting> {
  late StreamSubscription<DocumentSnapshot> _subscription;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    _subscription = triggerDocRef.snapshots().listen((snapshot) async {
      if (snapshot.exists && !_isNavigating && mounted) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data['takePhoto'] == false && data['latestImageName'] != null) {
          setState(() {
            _isNavigating = true;
          });

          final imageName = data['latestImageName'] as String;

          try {
            // Invalidate to ensure fresh data if this screen is revisited.
            ref.invalidate(imageBytesProvider(imageName));
            // Pre-fetch the image. The provider will cache the result.
            await ref.read(imageBytesProvider(imageName).future);

            if (mounted) {
              context.pushReplacement('/camera_preview', extra: imageName);
            }
          } catch (e) {
            if (mounted) {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to load image: $e'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('OK'),
                      onPressed: () {
                        context.pop();
                        // Go back to the previous screen on error.
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                  ],
                ),
              );
              setState(() {
                _isNavigating = false; // Allow retry or further actions.
              });
            }
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
