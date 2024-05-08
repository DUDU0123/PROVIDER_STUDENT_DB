import 'package:flutter/material.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';

class CommonAppBarWidget extends StatelessWidget {
  const CommonAppBarWidget({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  TextWidgetCommon(
        text: title,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
    );
  }
}