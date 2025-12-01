import 'package:flutter/cupertino.dart';
import 'package:flutter_app_nana_project/styles/colors.dart';

class Terms extends StatelessWidget {
  Terms({super.key});

  final title = Container(
    child: Text(
      "【 ご利用にあたって 】",
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
    ),
  );

  final dedcription = Container(
    margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
    child: Text(
      "このアプリで撮影, 入力された内容は、卒業制作展示\nの一環として会場内スクリーンに上映, 表示されます。",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
    ),
  );

  final articlesList = [
    "入力する内容に、第三者の著作権や肖像権を侵害する\nものを含めないでください。",
    "他の利用者や来場者を誹謗中傷したり、不快にさせる\nような表現はご遠慮ください。",
    "本アプリのご利用により発生したトラブルについて、\n主催者は責任を負いかねます。",
    "本アプリを利用された時点で、以上の内容に同意いた\nだいたものとみなします。",
  ];

  articleBuilder(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
      child: Text(
        "・ ${articlesList[index]}",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(articlesList.length, (index) {
          return articleBuilder(index);
        }),
      ),
    );
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 20, 50, 80),
        decoration: BoxDecoration(
          color: MainColors.white,
          border: Border.all(color: MainColors.black, width: 6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [title, dedcription, articles],
        ),
      ),
    );
  }
}
