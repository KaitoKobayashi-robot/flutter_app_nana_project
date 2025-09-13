import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'download_url.dart';
import 'package:flutter/material.dart';

class PageQR extends ConsumerWidget {
  const PageQR({super.key});

  push(BuildContext context) {
    context.go('/start');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var downloadURL = ref.watch(downloadURLProvider);
    final qr = Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: CupertinoColors.white,
      ),
      child: QrImageView(
        data: downloadURL,
        version: QrVersions.auto,
        size: 350,
        gapless: true,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: CupertinoColors.black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: CupertinoColors.black,
        ),
        errorStateBuilder: (cxt, err) {
          return Container(
            child: Center(
              child: Text(
                'Uh oh! Something went wrong...',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
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

    final titleText = const Text(
      '画像が完成しました！',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    final discriptionText = const Text(
      'QRコードから保存して、あなたの\n「褒めたい相手」に送りましょう！',
      style: TextStyle(
        fontSize: 20,
        // fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 200),
            titleText,
            SizedBox(height: 50),
            discriptionText,
            Expanded(child: Center(child: qr)),
            pushButton,
          ],
        ),
      ),
    );
  }
}
