import 'package:flutter/material.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';

showSnackbarAfterDataFetch({required String text, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kBlack,
        duration: const Duration(
          seconds: 2,
        ),
        behavior: SnackBarBehavior.fixed,
        content: TextWidgetCommon(
          text: text,
          color: kWhite,
        ),
      ),
    );
  }