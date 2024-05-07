import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/components/delete_dialog.dart';
import 'package:provider_student_db/components/snackbar.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import 'package:provider_student_db/views/add_edit/edit_student_page.dart';

Widget buildGrid({required int index, required BuildContext context}) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Container(
      // height: 10,
      // width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration:
          BoxDecoration(color: kGreen, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image:homeProvider.studentDataList[index].profileimage != null
                        ? MemoryImage(homeProvider.studentDataList[index].profileimage!)
                        : MemoryImage(
                            Uint8List(0),
                          ),
                    fit: BoxFit.cover,
                    scale: 10),
              ),
            ),
          ),
          TextWidgetCommon(
            overflow: TextOverflow.ellipsis,
            text:homeProvider.studentDataList[index].name ?? '',
            color: Colors.black,
            fontSize: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => EditStudentProfilePage(
                          studentModel:homeProvider.studentDataList[index]),
                    ),
                  )
                      .then(
                    (value) {
                      if (value != null) {
                        homeProvider.getAllStudentDetails();
                        showSnackbarAfterDataFetch(
                          context: context,
                          text: "Data Successfully Saved",
                        );
                      }
                    },
                  );
                  ;
                },
                icon: Icon(
                  Icons.edit,
                  color: kBlack,
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteAlertDialog(
                    context: context,
                    userId:homeProvider.studentDataList[index].id,
                  );
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: kBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }