import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_nana_project/pages/camera_control/page_camera_control.dart';
import 'package:flutter_app_nana_project/pages/camera_waiting/page_camera_waiting.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/page_setting_theme.dart';
import 'package:flutter_app_nana_project/pages/terms/page_terms.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/page_start.dart';
import 'package:flutter_app_nana_project/pages/camera/page_camera.dart';
import 'package:flutter_app_nana_project/pages/qr/page_qr.dart';
import 'package:flutter_app_nana_project/pages/write/page_write.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/pages/page_camera_shot.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/page_camera_preview.dart';

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
      GoRoute(path: "/terms", builder: (context, state) => const PageTerms()),
      GoRoute(
        path: '/setting_theme',
        builder: (context, state) => const PageSettingTheme(),
      ),
      GoRoute(
        path: '/camera_control',
        builder: (context, state) => const PageCameraControl(),
      ),
      GoRoute(path: '/camera', builder: (context, state) => PageCamera()),
      GoRoute(
        path: '/camera_shot',
        builder: (context, state) => const PageCameraShot(),
      ),
      GoRoute(
        path: '/camera_preview',
        builder: (context, state) => PageCameraPreview(extra: state.extra),
      ),
      GoRoute(
        path: '/camera_waiting',
        builder: (context, state) => const PageCameraWaiting(),
      ),
      GoRoute(path: '/write', builder: (context, state) => PageWrite()),
      GoRoute(path: '/QR', builder: (context, state) => const PageQR()),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'ZenMaruGothic'),
        ),
      ),
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
