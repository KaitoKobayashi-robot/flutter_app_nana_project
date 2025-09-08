import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PageQR extends StatelessWidget {
  const PageQR({super.key});

  push(BuildContext context) {
    context.push('/start');
  }

  @override
  Widget build(BuildContext context) {
    final pushButton = CupertinoButton(
      onPressed: () => push(context),
      child: const Text('最初から'),
    );

    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [const Text('QR画面'), pushButton],
        ),
      ),
    );
  }
}
