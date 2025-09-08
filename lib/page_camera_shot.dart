import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'CameraProviders.dart';
import 'page_camera_preview.dart';

class PageCameraShot extends ConsumerStatefulWidget {
  const PageCameraShot({super.key});

  @override
  ConsumerState<PageCameraShot> createState() => _PageCameraShotState();
}

class _PageCameraShotState extends ConsumerState<PageCameraShot> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(countdownProvider.notifier).startTimer();
    });
  }

  Future<void> takePicture() async {
    if (!context.mounted) return;

    try {
      final controller = await ref.read(cameraControllerProvider.future);
      final XFile image = await controller.takePicture();
      if (!context.mounted) return;
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => PageCameraPreview(imagePath: image.path),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('camera error'),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraControllerProvider);
    final countdown = ref.watch(countdownProvider);

    ref.listen<int>(countdownProvider, (previous, next) {
      if (next == 0 && previous != 0) {
        takePicture();
      }
    });

    buildCameraPreview(
      BuildContext context,
      CameraController controller,
      int countdown,
      WidgetRef ref,
      Future<void> Function() takePicture,
    ) {
      final size = MediaQuery.of(context).size;
      final cameraAsepectRatio = 1 / controller.value.aspectRatio;
      var scale = size.aspectRatio * cameraAsepectRatio;

      if (scale < 1) {
        scale = 1 / scale;
      }

      return Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: 0.7,
              child: AspectRatio(
                aspectRatio: cameraAsepectRatio,
                child: CameraPreview(controller),
              ),
            ),
          ),
          if (countdown > 0)
            Center(
              child: Text(
                '$countdown',
                style: const TextStyle(
                  fontSize: 100,
                  color: Color.fromARGB(255, 253, 141, 255),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: CupertinoColors.black,
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    }

    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 146),
      child: controller.when(
        data: (controller) => buildCameraPreview(
          context,
          controller,
          countdown,
          ref,
          takePicture,
        ),
        loading: () => const Center(child: CupertinoActivityIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
