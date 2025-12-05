import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/qr/widgets/buttons.dart';
import 'package:flutter_app_nana_project/service/se_manager.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/download_url_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';
import 'package:svg_provider/svg_provider.dart';

class PageQR extends ConsumerWidget {
  const PageQR({super.key});

  push(BuildContext context) {
    context.go('/start');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(seManagerProvider).playQR();
    const String assetName = 'assets/images/hand_qr.svg';

    final svg = SvgProvider(assetName);

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
        embeddedImage: svg,
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

    final titleText = const Text(
      '画像が完成しました！',
      style: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w900,
        color: MainColors.black,
      ),
    );

    final discriptionText = const Text(
      'QRコードから完成した画像を保存して、\n伝えたい相手に送ってみよう！',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100),
            Logo(height: 150),
            SizedBox(height: 70),
            titleText,
            SizedBox(height: 50),
            discriptionText,
            Expanded(child: Center(child: qr)),
            Container(
              alignment: Alignment.center,
              width: ButtonArea.width,
              height: ButtonArea.height,
              child: SingleButton(onPressed: () => push(context)),
            ),
          ],
        ),
      ),
    );
  }
}
