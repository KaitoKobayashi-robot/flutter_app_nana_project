import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_nana_project/pages/camera/widgets/buttons.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:go_router/go_router.dart';

class PageCamera extends StatelessWidget {
  PageCamera({super.key});

  final triggerDocRef = FirebaseFirestore.instance
      .collection('camera')
      .doc('trigger');

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
            Expanded(
              child: Center(
                child: const Text(style: TextStyle(fontSize: 40), '撮影画面'),
              ),
            ),
            SingleButton(onPressed: () => push(context)),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
