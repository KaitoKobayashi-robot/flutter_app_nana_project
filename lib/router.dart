import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_nana_project/pages/camera_control/page_camera_control.dart';
import 'package:flutter_app_nana_project/pages/camera_waiting/page_camera_waiting.dart';
import 'package:flutter_app_nana_project/pages/theme_setting/page_setting_theme.dart';
import 'package:flutter_app_nana_project/pages/terms/page_terms.dart';
import 'package:flutter_app_nana_project/pages/start/page_start.dart';
import 'package:flutter_app_nana_project/pages/camera/page_camera.dart';
import 'package:flutter_app_nana_project/pages/qr/page_qr.dart';
import 'package:flutter_app_nana_project/pages/write/page_write.dart';
import 'package:flutter_app_nana_project/pages/page_camera_shot.dart';
import 'package:flutter_app_nana_project/pages/camera_preview/page_camera_preview.dart';
import 'package:flutter_app_nana_project/pages/theme/page_theme.dart';

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
    transitionDuration: const Duration(milliseconds: 200),
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
    GoRoute(
      path: "/terms",
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageTerms(),
      ),
    ),
    GoRoute(
      path: '/theme',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageTheme(),
      ),
    ),
    GoRoute(
      path: '/setting_theme',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageSettingTheme(),
      ),
    ),
    GoRoute(
      path: '/camera',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: PageCamera(),
      ),
    ),
    GoRoute(
      path: '/camera_control',
      builder: (context, state) => const PageCameraControl(),
    ),
    GoRoute(
      path: '/camera_shot',
      builder: (context, state) => const PageCameraShot(),
    ),
    GoRoute(
      path: '/camera_waiting',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageCameraWaiting(),
      ),
    ),
    GoRoute(
      path: '/camera_preview',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: PageCameraPreview(extra: state.extra),
      ),
    ),
    GoRoute(
      path: '/write',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: PageWrite(),
      ),
    ),
    GoRoute(
      path: '/QR',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const PageQR(),
      ),
    ),
  ],
);
