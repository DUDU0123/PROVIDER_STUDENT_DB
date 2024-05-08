import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/common_appbar_widget.dart';
import 'package:provider_student_db/components/common/image_avatar.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/components/common/textfields_widget.dart';
import 'package:provider_student_db/components/snackbar.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/enums/pagetype_enum.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/edit_student_provider.dart';
import 'package:provider_student_db/provider/home_provider.dart';

class EditStudentProfilePage extends StatelessWidget {
  EditStudentProfilePage({super.key, required this.studentModel});
  final StudentDataBaseModel studentModel;

  File? studentImage;

  @override
  Widget build(BuildContext context) {
    final addStudentProvider =
        Provider.of<AddStudentProvider>(context, listen: false);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBarWidget(
          title: "Edit Student Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Consumer<EditStudentProvider>(
            builder: (context, editStudentProvider, child) => Column(
              children: [
                studentModel.profileimage != null ||
                        editStudentProvider.studentImage != null
                    ? ImageAvatar(
                        editStudentProvider: editStudentProvider,
                        backgroundImage: 
                            editStudentProvider.studentImage != null
                                ? MemoryImage(editStudentProvider.studentImage!
                                    .readAsBytesSync())
                                : MemoryImage(studentModel.profileimage!),
                      )
                    : ImageAvatar(
                        editStudentProvider: editStudentProvider,
                        backgroundImage: const AssetImage(
                          "assets/person.png",
                        ),
                      ),
                kHeight15,
                TextFieldsWidget(
                  pageType: PageTypeEnum.editStudent,
                  addStudentProvider: addStudentProvider,
                  editStudentProvider: editStudentProvider,
                ),
                kHeight15,
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () async {
                        final homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);
                        editStudentProvider.saveData(
                          context: context,
                          studentModel: studentModel,
                        );

                        RegExp regExp =
                            RegExp(r"^(0?[1-9]|[1-9][0-9]|[1][01][0-9]|120)$");
                        RegExp stringRegExp = RegExp(r"^[^0-9,]*$");
                        if (editStudentProvider.namevalidate &&
                            editStudentProvider.agevalidate &&
                            editStudentProvider.placevalidate &&
                            editStudentProvider.standardvalidate &&
                            regExp.hasMatch(
                                editStudentProvider.ageController.text) &&
                            stringRegExp.hasMatch(
                                editStudentProvider.nameController.text) &&
                            stringRegExp.hasMatch(
                                editStudentProvider.placeController.text)) {
                          var student = StudentDataBaseModel();
                          student.profileimage =
                              editStudentProvider.studentImage != null
                                  ? editStudentProvider.studentImage!
                                      .readAsBytesSync()
                                  : studentModel.profileimage;
                          student.id = studentModel.id;
                          student.name =
                              editStudentProvider.nameController.text;
                          student.age = editStudentProvider.ageController.text;
                          student.place =
                              editStudentProvider.placeController.text;
                          student.standard =
                              editStudentProvider.standardController.text;
                          await homeProvider.dbService
                              .updateStudentData(student);
                          homeProvider.getAllStudentDetails();
                          Navigator.pop(context);
                          showSnackbarAfterDataFetch(
                              text: "Updated Successfully", context: context);
                        } else {
                          showSnackbarAfterDataFetch(
                              text: "Fill all fields correctly",
                              context: context);
                        }
                      },
                      child: TextWidgetCommon(
                        text: "Save",
                        color: kWhite,
                      ),
                    ),
                    kWidth15,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () {
                        editStudentProvider.clearAll();
                      },
                      child: TextWidgetCommon(
                        text: "Clear",
                        color: kWhite,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}