import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class PageCameraPreview extends StatefulWidget {
  final String imagePath;

  const PageCameraPreview({super.key, required this.imagePath});

  @override
  State<PageCameraPreview> createState() => _PageCameraPreviewState();
}

class _PageCameraPreviewState extends State<PageCameraPreview> {
  Uint8List? imageData;
  bool isLoading = true;
  bool isSaved = false;
  File? flippedImageFile;

  @override
  void initState() {
    super.initState();
    initializeAndFlipImage();
  }

  push(BuildContext context, Uint8List imageData) {
    context.push('/write', extra: imageData);
  }

  back(BuildContext context) {
    context.push('/camera');
  }

  Future<void> initializeAndFlipImage() async {
    final file = File(widget.imagePath);
    final bytes = await file.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage == null) {
      setState(() {
        isLoading = false;
      });
      throw Exception('画像のデコードに失敗しました');
    }

    // 画像を左右反転
    img.Image flippedImage = img.flipHorizontal(originalImage);
    final flippedBytes = Uint8List.fromList(img.encodeJpg(flippedImage));
    if (!mounted) return;
    setState(() {
      imageData = flippedBytes;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        isSaved = false;
        push(context, imageData!);
      },
      child: pushButtonChild,
    );

    final backButton = CupertinoButton(
      onPressed: () => back(context),
      child: backButtonChild,
    );

    final image = imageData == null
        ? const Text('NO IMAGE')
        : Transform.scale(
            scale: 0.7,
            child: Image.memory(imageData!, fit: BoxFit.contain),
          );

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: Center(
        child: isLoading
            ? const CupertinoActivityIndicator(radius: 40)
            : imageData == null
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
