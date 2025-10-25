import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/write/styles/ratio.dart';
import 'package:flutter_app_nana_project/pages/write/widgets/buttons.dart';
import 'package:flutter_app_nana_project/pages/write/widgets/write_container.dart';
import 'package:flutter_app_nana_project/providers/percent_indicator_provider.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_app_nana_project/widgets/logo.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/download_url_provider.dart';
import '../../providers/user_image_provider.dart';
import 'package:flutter_app_nana_project/widgets/percent_indicator.dart';
import 'package:flutter_app_nana_project/widgets/button.dart';

final imageInfoProvider = Provider.autoDispose<Map<String, double>>((ref) {
  final imageData = ref.watch(userImageProvider);
  if (imageData == null) {
    return {'width': 0.0, 'height': 0.0};
  }
  final image = img.decodeImage(imageData);
  if (image != null) {
    return {'width': image.width.toDouble(), 'height': image.height.toDouble()};
  } else {
    return {'width': 0.0, 'height': 0.0};
  }
});

class PageWrite extends ConsumerStatefulWidget {
  const PageWrite({super.key});

  @override
  ConsumerState<PageWrite> createState() => _PageWriteState();
}

class _PageWriteState extends ConsumerState<PageWrite> {
  final storageRef = FirebaseStorage.instance.ref();
  late final SignatureController _controller;
  final GlobalKey _completeImgKey = GlobalKey();
  final ValueNotifier<bool> _hasSignedNotifire = ValueNotifier<bool>(false);
  static const imagescale = 4.5;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      strokeCap: StrokeCap.round,
      penStrokeWidth: 5,
      penColor: MainColors.black,
      exportBackgroundColor: CupertinoColors.transparent,
    );
    _controller.addListener(() {
      if (_hasSignedNotifire.value != _controller.isNotEmpty) {
        _hasSignedNotifire.value = _controller.isNotEmpty;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hasSignedNotifire.dispose();
    super.dispose();
  }

  Future<void> captureAndSavePng(void Function(double) onProgress) async {
    onProgress(0.1);

    final boudary =
        _completeImgKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
    final ui.Image image = await boudary.toImage(pixelRatio: imagescale);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    onProgress(0.25);
    await Future.delayed(const Duration(milliseconds: 500));

    if (byteData != null) {
      final pngBytes = byteData.buffer.asUint8List();
      try {
        String filename =
            'user_images/image${DateTime.now().microsecondsSinceEpoch}.png';
        final uploadRef = storageRef.child(filename);

        onProgress(0.5);

        await uploadRef.putData(pngBytes);

        onProgress(0.75);

        final downloadURL = await uploadRef.getDownloadURL();
        ref.read(downloadURLProvider.notifier).state = downloadURL;

        onProgress(1.0);
      } catch (e) {
        debugPrint('File upload failed: $e');
      }
    }
  }

  void _handleClear() {
    _controller.clear();
  }

  void _handleUndo() {
    _controller.undo();
  }

  void _handleRedo() {
    _controller.redo();
  }

  Future<void> push(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await captureAndSavePng((progress) {
      ref.read(uploadProgressProvider.notifier).state = progress;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (!context.mounted) return;
    context.push('/QR');
  }

  @override
  Widget build(BuildContext context) {
    final imageData = ref.watch(userImageProvider);

    if (imageData == null) {
      return CupertinoPageScaffold(
        backgroundColor: MainColors.bgColor,
        child: Center(child: const Text('NO IMAGE')),
      );
    }

    ValueListenableBuilder<bool> buttonBuilder = ValueListenableBuilder(
      valueListenable: _hasSignedNotifire,
      builder: (context, hasSigned, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(
              onPressed: hasSigned ? _handleClear : null,
              child: const Text(
                'クリア',
                style: TextStyle(
                  fontFamily: "ZenMaruGothic",
                  color: MainColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CupertinoButton(
              onPressed: hasSigned ? _handleUndo : null,
              child: const Text(
                '一つ戻る',
                style: TextStyle(
                  fontFamily: "ZenMaruGothic",
                  color: MainColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CupertinoButton(
              onPressed: hasSigned ? _handleRedo : null,
              child: const Text(
                'やり直す',
                style: TextStyle(
                  fontFamily: "ZenMaruGothic",
                  color: MainColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    final mediaWidth = MediaQuery.of(context).size.width;
    final signatureWidth = mediaWidth * Ratio.widthRatio * 0.97;
    const signatureHeight = 270.0;

    final signatureArea = SizedBox(
      width: signatureWidth,
      height: signatureHeight,
      child: Signature(
        controller: _controller,
        width: signatureWidth,
        height: signatureHeight,
        backgroundColor: CupertinoColors.transparent,
      ),
    );

    return CupertinoPageScaffold(
      backgroundColor: MainColors.bgColor,
      child: SafeArea(
        child: isLoading
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 70, child: Logo(height: 100)),
                  progressIndicatorBuilder(context, ref),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: const Text(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                      '褒めたい相手に「褒め言葉」を書き込もう！',
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: mediaWidth * Ratio.widthRatio,
                        child: RepaintBoundary(
                          key: _completeImgKey,
                          child: Container(
                            decoration: BoxDecoration(
                              border: BoxBorder.all(
                                color: MainColors.black,
                                width: 6,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(4),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  WriteContainer(imageBytes: imageData),
                                  Positioned(bottom: 17, child: signatureArea),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      buttonBuilder,
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: ButtonArea.width,
                    height: ButtonArea.height * 0.8,
                    child: SingleButton(onPressed: () => push(context)),
                  ),
                ],
              ),
      ),
    );
  }
}
