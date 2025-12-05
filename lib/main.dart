import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_app_nana_project/router.dart';
import 'package:flutter_app_nana_project/service/bgm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final scope = ProviderScope(child: Home());
  runApp(scope);
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bgmServiceProvider);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appLifecycleStateProvider.notifier).state = state;
    final bgmService = ref.read(bgmServiceProvider);
    if (state == AppLifecycleState.paused) {
      bgmService.pauseBgm();
    } else if (state == AppLifecycleState.resumed) {
      bgmService.resumeBgm();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      theme: CupertinoThemeData(
        textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'ZenMaruGothic',
            color: MainColors.black,
          ),
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
