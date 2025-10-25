import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraGraphic extends StatelessWidget {
  final String text;
  final bool isLoading;
  const CameraGraphic({super.key, required this.text, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/images/take_photo.svg';
    final Widget svgCamera = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Camera Graphic',
      height: 350,
    );
    final Widget svgArrows = SvgPicture.asset(
      'assets/images/arrows.svg',
      semanticsLabel: 'arrows',
      height: 60,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        svgCamera,
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
          child: isLoading ? SizedBox(height: 60) : svgArrows,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: MainColors.black,
          ),
        ),
      ],
    );
  }
}
