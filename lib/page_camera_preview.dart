import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/CameraProviders.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'UserImage.dart';

class PageCameraPreview extends ConsumerWidget {
  const PageCameraPreview({super.key});

  push(BuildContext context) {
    context.push('/write');
  }

  back(BuildContext context, WidgetRef ref) {
    ref.invalidate(cameraControllerProvider);
    ref.read(countdownProvider.notifier).resetTimer();
    context.go('/camera');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageData = ref.watch(userImageProvider);
    final backButtonChild = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
      width: 230,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 141, 255),
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'もう一度撮る',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          const Text(
            'ReTake',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final pushButtonChild = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
      width: 230,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '次へ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          const Text(
            'NEXT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final pushButton = CupertinoButton(
      onPressed: () {
        push(context);
      },
      child: pushButtonChild,
    );

    final backButton = CupertinoButton(
      onPressed: () => back(context, ref),
      child: backButtonChild,
    );

    final image = imageData == null
        ? const Text('NO IMAGE')
        : Transform.scale(
            scale: 0.7,
            child: Image.memory(imageData, fit: BoxFit.contain),
          );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: imageData == null
            ? const Text('NO IMAGE')
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Center(child: image)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [backButton, pushButton],
                  ),
                ],
              ),
      ),
    );
  }
}
