import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

import 'package:flutter_app_nana_project/pages/write/widgets/theme_box.dart';
import 'package:flutter_app_nana_project/pages/write/widgets/image_area.dart';

class WriteContainer extends StatelessWidget {
  final Uint8List imageBytes;
  const WriteContainer({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemeBox(),
        ImageArea(imageBytes: imageBytes),
      ],
    );
  }
}
