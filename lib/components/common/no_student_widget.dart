import 'package:flutter/material.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';

class NoStudentWidget extends StatelessWidget {
  const NoStudentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextWidgetCommon(
          text: "No student available",
          color: kBlack,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      );
  }
}
