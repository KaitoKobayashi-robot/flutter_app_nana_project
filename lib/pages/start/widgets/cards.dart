import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/styles/colors.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class Config {
  static const double svgLogoSize = 160;
  static const double svgNumSize = 60;
  static const double lottieWidth = 250;
  static const double safeAreaWidth = 200;
  static const double safeAreaHeight = 250;
}

class Cards extends StatelessWidget {
  Cards({super.key});

  final lottieBoat = Lottie.asset("assets/json/boat.json", width: 50);

  final lottieSelectTheme = Lottie.asset(
    "assets/json/finger.json",
    width: Config.lottieWidth,
  );

  final lottieTakePhoto = Lottie.asset(
    "assets/json/camera.json",
    width: Config.lottieWidth,
  );

  final lottieWriteComments = Lottie.asset(
    "assets/json/pen.json",
    width: Config.lottieWidth,
  );

  final lottieSendMessage = Lottie.asset(
    "assets/json/mail.json",
    width: Config.lottieWidth,
  );

  final Widget svgSelectTheme = SvgPicture.asset(
    'assets/images/select_theme.svg',
    semanticsLabel: 'Select Theme',
    width: Config.svgLogoSize,
  );
  final Widget svgTakePhoto = SvgPicture.asset(
    'assets/images/take_photo.svg',
    semanticsLabel: 'Take Photo',
    width: Config.svgLogoSize,
  );
  final Widget svgWriteComments = SvgPicture.asset(
    'assets/images/write_comments.svg',
    semanticsLabel: 'Write Comments',
    width: Config.svgLogoSize,
  );
  final Widget svgSendMessage = SvgPicture.asset(
    'assets/images/send_message.svg',
    semanticsLabel: 'Send Message',
    width: Config.svgLogoSize,
  );

  final Widget svg1 = SvgPicture.asset(
    'assets/images/1.svg',
    semanticsLabel: '1',
    width: Config.svgNumSize,
  );
  final Widget svg2 = SvgPicture.asset(
    'assets/images/2.svg',
    semanticsLabel: '2',
    width: Config.svgNumSize,
  );
  final Widget svg3 = SvgPicture.asset(
    'assets/images/3.svg',
    semanticsLabel: '3',
    width: Config.svgNumSize,
  );
  final Widget svg4 = SvgPicture.asset(
    'assets/images/4.svg',
    semanticsLabel: '4',
    width: Config.svgNumSize,
  );

  cardBuilder(String text, Widget svgLogo, Widget svgNum, bool isPaper) {
    return Container(
      // margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      height: 200,
      width: 750,
      decoration: BoxDecoration(
        // color: CardColors.bgColor,
        // border: Border.all(width: 6, color: MainColors.black),
        // borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              // color: CupertinoColors.activeGreen,
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: SizedBox(
                width: Config.safeAreaWidth,
                height: Config.safeAreaHeight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(isPaper ? 40 : 0, 0, 0, 0),
                  child: Center(child: svgLogo),
                ),
              ),
            ),
            Container(
              // color: CupertinoColors.activeBlue,
              child: svgNum,
            ),
            SizedBox(width: 10),
            Container(
              // color: CupertinoColors.destructiveRed,
              child: Text(
                text,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Center(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: CardColors.bgColor,
                border: Border.all(width: 6, color: MainColors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "【手順】",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
                  ),
                  cardBuilder("ほめお題を選ぶ", lottieSelectTheme, svg1, true),
                  cardBuilder("写真を撮る", lottieTakePhoto, svg2, false),
                  cardBuilder("ほめ言葉を書く", lottieWriteComments, svg3, true),
                  cardBuilder('ほめたい相手に送ろう！', lottieSendMessage, svg4, false),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Lottie.asset("assets/json/boat.json", height: 50),
        ),
      ],
    );
  }
}
