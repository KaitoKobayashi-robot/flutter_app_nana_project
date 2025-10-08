import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';
import 'package:flutter_app_nana_project/pages/camera_control/page_camera_control.dart';
import 'package:flutter_app_nana_project/pages/camera_waiting/page_camera_waiting.dart';
import 'package:flutter_app_nana_project/pages/setting_theme/page_setting_theme.dart';
import 'package:flutter_app_nana_project/pages/terms/page_terms.dart';
import 'package:flutter_app_nana_project/pages/start/page_start.dart';
import 'package:flutter_app_nana_project/pages/camera/page_camera.dart';
import 'package:flutter_app_nana_project/pages/qr/page_qr.dart';
import 'package:flutter_app_nana_project/pages/write/page_write.dart';
import 'package:flutter_app_nana_project/pages/page_camera_shot.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/page_camera_preview.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 350), // アニメーション時間を指定
  );
}

final router = GoRouter(
  initialLocation: '/start',
  routes: [
    GoRoute(
      path: '/start',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageStart(),
      ),
    ),
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
