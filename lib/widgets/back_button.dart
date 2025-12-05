import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BackButton extends ConsumerWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triggerDocRef = FirebaseFirestore.instance
        .collection('camera')
        .doc('trigger');

    push(BuildContext context) {
      triggerDocRef.update({'takePhoto': false});
      ref.read(seManagerProvider).playTapSound();
      context.go("/homete");
    }

    return CupertinoButton(
      onPressed: () => push(context),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/back.svg", width: 50),
          Text(
            "最初にもどる",
            style: TextStyle(
              fontFamily: 'ZenMaruGothic',
              color: MainColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
