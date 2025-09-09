import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'DownloadURL.dart';
import 'package:flutter/material.dart';

class PageQR extends ConsumerWidget {
  const PageQR({super.key});

  push(BuildContext context) {
    context.push('/start');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var downloadURL = ref.watch(downloadURLProvider);
    if (downloadURL == '') {
      downloadURL = 'https://google.com';
    }

    final qr = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CupertinoColors.white,
      ),
      child: QrImageView(
        data: downloadURL,
        version: 2,
        size: 400,
        gapless: true,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: CupertinoColors.black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: CupertinoColors.black,
        ),
      ),
    );

    final button = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
      width: 430,
      height: 140,
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
            '最初に戻る',
            style: TextStyle(
              color: Color.fromARGB(255, 249, 249, 146),
              fontSize: 25,
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
            'return',
            style: TextStyle(
              color: Color.fromARGB(255, 249, 249, 146),
              fontSize: 15,
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
      onPressed: () => push(context),
      child: button,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Center(child: qr)),
            pushButton,
          ],
        ),
      ),
    );
  }
}
