import 'package:flutter/material.dart';
import 'package:provider_student_db/components/common/text_field_common_widget.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/enums/pagetype_enum.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/edit_student_provider.dart';

class TextFieldsWidget extends StatelessWidget {
  TextFieldsWidget({
    super.key,
    required this.editStudentProvider,
    required this.addStudentProvider,
    required this.pageType,
  });

  EditStudentProvider editStudentProvider;
  AddStudentProvider addStudentProvider;
  final PageTypeEnum pageType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldCommonWidget(
          keyboardType: TextInputType.text,
          nameController: pageType == PageTypeEnum.editStudent
              ? editStudentProvider.nameController
              : addStudentProvider.nameController,
          hintText: "Name",
          labelText: "Enter name",
        ),
        kHeight15,
        TextFieldCommonWidget(
          keyboardType: TextInputType.number,
          nameController: pageType == PageTypeEnum.editStudent
              ? editStudentProvider.ageController
              : addStudentProvider.ageController,
          hintText: "Age",
          labelText: "Enter age",
        ),
        kHeight15,
        TextFieldCommonWidget(
          keyboardType: TextInputType.text,
          nameController: pageType == PageTypeEnum.editStudent
              ? editStudentProvider.placeController
              : addStudentProvider.placeController,
          hintText: "Place",
          labelText: "Enter place",
        ),
        kHeight15,
        TextFieldCommonWidget(
          keyboardType: TextInputType.text,
          nameController: pageType == PageTypeEnum.editStudent
              ? editStudentProvider.standardController
              : addStudentProvider.standardController,
          hintText: "Class",
          labelText: "Enter class",
        ),
      ],
    );
  }
}