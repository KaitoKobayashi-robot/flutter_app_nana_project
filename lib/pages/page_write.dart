import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_nana_project/providers/percent_indicator_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/download_url_provider.dart';
import '../providers/user_image_provider.dart';
import 'package:flutter_app_nana_project/pages/page_percent_indicator.dart';

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
  static const imagescale = 1.4;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: CupertinoColors.black,
      exportBackgroundColor: CupertinoColors.white,
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
    final ui.Image image = await boudary.toImage(pixelRatio: 3.0);
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
    final imageInfo = ref.watch(imageInfoProvider);

    if (imageData == null) {
      return CupertinoPageScaffold(
        backgroundColor: Color.fromARGB(255, 249, 249, 146),
        child: Center(child: const Text('NO IMAGE')),
      );
    }

    final imageWidth = imageInfo['width']! / imagescale;
    final imageHeight = imageInfo['height']! / imagescale;

    ValueListenableBuilder<bool> buttonBuilder = ValueListenableBuilder(
      valueListenable: _hasSignedNotifire,
      builder: (context, hasSigned, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: hasSigned ? _handleClear : null,
                  child: const Text('クリア'),
                ),
                const SizedBox(width: 20),
                CupertinoButton(
                  onPressed: hasSigned ? _handleUndo : null,
                  child: const Text('元に戻す'),
                ),
                const SizedBox(width: 20),
                CupertinoButton(
                  onPressed: hasSigned ? _handleRedo : null,
                  child: const Text('やり直す'),
                ),
              ],
            ),
          ],
        );
      },
    );

    final completeButton = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
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
            '完成！',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
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
            'complete!',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
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
      child: completeButton,
    );

    const signatureWidth = 450.0;
    const signatureHeight = 300.0;

    final signatureArea = SizedBox(
      width: signatureWidth,
      height: signatureHeight,
      child: Signature(
        controller: _controller,
        width: signatureWidth,
        height: signatureHeight,
        backgroundColor: CupertinoColors.white,
      ),
    );

    final image = Image.memory(
      scale: imagescale,
      imageData,
      fit: BoxFit.contain,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: SafeArea(
        child: isLoading
            ? progressIndicatorBuilder(context, ref)
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 30),
                  const Text(
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    '褒めたい相手に「褒め言葉」を書き込もう！',
                  ),
                  SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    child: RepaintBoundary(
                      key: _completeImgKey,
                      child: SizedBox(
                        width: imageWidth,
                        height: imageHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(alignment: Alignment.center, child: image),
                            Align(
                              alignment: Alignment(0, 0.8),
                              child: Card(elevation: 4, child: signatureArea),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buttonBuilder,
                  SizedBox(height: 30),
                  pushButton,
                ],
              ),
      ),
    );
  }
}
