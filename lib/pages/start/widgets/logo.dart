import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/logo.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Homete LOGO',
      height: 300,
    );
    return svg;
  }
}
