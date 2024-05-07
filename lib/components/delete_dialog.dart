import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/components/snackbar.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import '../constants/colors/colors.dart';

void deleteAlertDialog({
  required BuildContext context,
  required int? userId,
}) {
 final homeProvider =  Provider.of<HomeProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: TextWidgetCommon(
          text: "Delete",
          color: kBlack,
        ),
        content: TextWidgetCommon(
          text: "Do you want to delete the student?",
          color: kBlack,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextWidgetCommon(
              text: "Close",
              color: kBlack,
            ),
          ),
          TextButton(
            onPressed: () async {
              final result = await homeProvider.dbService.deleteStudentData(userId);

              if (result != null) {
                Navigator.pop(context);
                homeProvider.getAllStudentDetails();
                showSnackbarAfterDataFetch(
                  context: context,
                  text: "Data Successfully Deleted",
                );
              }
              homeProvider.getAllStudentDetails();
            },
            child: TextWidgetCommon(
              text: "Delete",
              color: kRed,
            ),
          ),
        ],
      );
    },
  );
}
