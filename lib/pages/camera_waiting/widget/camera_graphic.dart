import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraGraphic extends StatelessWidget {
  final String text;
  const CameraGraphic({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/take_photo.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Camera Graphic',
      height: 350,
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(top: 80, child: svg),
        Positioned(
          bottom: 80,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: MainColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
