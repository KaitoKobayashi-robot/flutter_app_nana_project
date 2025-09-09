import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/page_start.dart';
import 'package:flutter_app_nana_project/page_camera.dart';
import 'package:flutter_app_nana_project/page_QR.dart';
import 'package:flutter_app_nana_project/page_write.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/page_camera_shot.dart';
import 'package:flutter_app_nana_project/page_camera_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final scope = ProviderScope(child: Home());
  runApp(scope);
}

class Home extends ConsumerWidget {
  Home({super.key});

  final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(path: '/start', builder: (context, state) => const PageStart()),
      GoRoute(path: '/camera', builder: (context, state) => const PageCamera()),
      GoRoute(
        path: '/camera_shot',
        builder: (context, state) => const PageCameraShot(),
      ),
      GoRoute(
        path: '/camera_preview',
        builder: (context, state) => const PageCameraPreview(),
      ),
      GoRoute(path: '/write', builder: (context, state) => PageWrite()),
      GoRoute(path: '/QR', builder: (context, state) => const PageQR()),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
