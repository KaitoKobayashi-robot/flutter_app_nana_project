import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraGraphic extends StatelessWidget {
  const CameraGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/camera_graphic.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Camera Graphic',
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        svg,
        Positioned(
          bottom: 80,
          child: Text(
            "準備ができたら撮影を始めてね",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
