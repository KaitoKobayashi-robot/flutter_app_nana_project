import 'package:flutter/cupertino.dart';

class Terms extends StatelessWidget {
  Terms({super.key});

  final title = Container(
    child: Text("【 ご利用にあたって 】", style: TextStyle(fontSize: 50)),
  );

  final dedcription = Container(
    margin: EdgeInsets.fromLTRB(0, 100, 0, 50),
    child: Text(
      "このアプリで撮影, 入力された内容は、卒業制作展示\nの一環として会場内スクリーンに上映, 表示されます。",
      style: TextStyle(fontSize: 30),
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
      margin: EdgeInsets.all(20),
      child: Text("・ ${articlesList[index]}", style: TextStyle(fontSize: 20)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(articlesList.length, (index) {
          return articleBuilder(index);
        }),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title,
        dedcription,
        Expanded(child: articles),
      ],
    );
  }
}
