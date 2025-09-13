import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_nana_project/pages/page_setting_theme.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/page_start.dart';
import 'package:flutter_app_nana_project/pages/page_camera.dart';
import 'package:flutter_app_nana_project/pages/page_qr.dart';
import 'package:flutter_app_nana_project/pages/page_write.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/pages/page_camera_shot.dart';
import 'package:flutter_app_nana_project/pages/page_camera_preview.dart';

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
      GoRoute(
        path: '/setting_theme',
        builder: (context, state) => const PageSettingTheme(),
      ),
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja', 'JP')],
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
