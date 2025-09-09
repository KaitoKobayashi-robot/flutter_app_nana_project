import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'DownloadURL.dart';

class PageWrite extends ConsumerStatefulWidget {
  final Uint8List imageData;
  const PageWrite({super.key, required this.imageData});

  @override
  ConsumerState<PageWrite> createState() => _PageWriteState();
}

class _PageWriteState extends ConsumerState<PageWrite> {
  final storageRef = FirebaseStorage.instance.ref();
  late final SignatureController _controller;
  final GlobalKey _completeImgKey = GlobalKey();
  bool _hasSigned = false;
  Uint8List? get imageData => widget.imageData;
  static const imagescale = 1.2;
  double imageWidth = 0.0;
  double imageHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: CupertinoColors.black,
      exportBackgroundColor: CupertinoColors.white,
    );
    _controller.onDrawEnd = () {
      setState(() {
        _hasSigned = _controller.isNotEmpty;
      });
    };
    if (widget.imageData.isNotEmpty) {
      img.Image decodedImage = img.decodeImage(imageData!)!;
      imageWidth = decodedImage.width.toDouble() / imagescale;
      imageHeight = decodedImage.height.toDouble() / imagescale;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> captureAndSavePng() async {
    final boudary =
        _completeImgKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;
    final ui.Image image = await boudary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      final pngBytes = byteData.buffer.asUint8List();
      final tempDir = Directory.systemTemp;
      final file = await File('${tempDir.path}/signed_image_.png').create();
      await file.writeAsBytes(pngBytes);
      await GallerySaver.saveImage(file.path);
      try {
        String filename =
            'user_images/image${DateTime.now().microsecondsSinceEpoch}.png';
        final uploadRef = storageRef.child(filename);
        await uploadRef.putData(pngBytes);
        final downloadURL = await uploadRef.getDownloadURL();
        ref.read(downloadURLProvider.notifier).state = downloadURL;
      } catch (e) {
        debugPrint('File upload failed: $e');
      }
    }
  }

  void _handleClear() {
    _controller.clear();
    setState(() {
      _hasSigned = false;
    });
  }

  push(BuildContext context) {
    captureAndSavePng();
    context.push('/percent_indicator');
  }

  @override
  Widget build(BuildContext context) {
    final pushButton = CupertinoButton(
      onPressed: () => push(context),
      child: const Text('完成'),
    );

    final clearButton = CupertinoButton(
      onPressed: _hasSigned ? _handleClear : null,
      child: const Text('クリア'),
    );

    final undoButton = CupertinoButton(
      onPressed: _hasSigned
          ? () {
              _controller.undo();
              setState(() {
                _hasSigned = _controller.isNotEmpty;
              });
            }
          : null,
      child: const Text('元に戻す'),
    );

    final redoButton = CupertinoButton(
      onPressed: _hasSigned
          ? () {
              _controller.redo();
              setState(() {
                _hasSigned = _controller.isNotEmpty;
              });
            }
          : null,
      child: const Text('やり直す'),
    );

    final buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        clearButton,
        const SizedBox(width: 20),
        undoButton,
        const SizedBox(width: 20),
        redoButton,
      ],
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
      imageData!,
      fit: BoxFit.contain,
    );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('書き込み画面'),
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
            buttonRow,
            pushButton,
          ],
        ),
      ),
    );
  }
}
