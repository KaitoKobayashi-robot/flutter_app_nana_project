import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class CameraGraphic extends StatelessWidget {
  const CameraGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    // const String assetName = 'assets/images/take_photo.svg';
    // final Widget svg = SvgPicture.asset(
    //   assetName,
    //   semanticsLabel: 'Camera Graphic',
    //   height: 350,
    // );
    final Widget lottie = Lottie.asset("assets/json/camera.json", width: 350);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 700,
          height: 630,
          decoration: BoxDecoration(
            color: MainColors.white,
            border: BoxBorder.all(color: MainColors.black, width: 6),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(top: 80, child: lottie),
        Positioned(
          bottom: 80,
          child: Text(
            "準備ができたら撮影を始めてね",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
