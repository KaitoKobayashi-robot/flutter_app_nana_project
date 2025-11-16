import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/pages/start/styles/colors.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class Config {
  static const double svgLogoSize = 160;
  static const double svgNumSize = 50;
  static const double lottieWidth = 200;
}

class Cards extends StatelessWidget {
  Cards({super.key});

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

  cardBuilder(String text, Widget svgLogo, Widget svgNum) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      height: 190,
      width: 750,
      decoration: BoxDecoration(
        color: CardColors.bgColor,
        border: Border.all(width: 6, color: MainColors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: svgLogo,
            ),
            svgNum,
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardBuilder("ランダムの「ほめお題」を選ぶ", lottieSelectTheme, svg1),
          cardBuilder("写真を撮る", lottieTakePhoto, svg2),
          cardBuilder("お題にあったほめ言葉を書く", lottieWriteComments, svg3),
          cardBuilder('画像を保存して、ほめたい\n相手に送ろう！', lottieSendMessage, svg4),
        ],
      ),
    );
  }
}
