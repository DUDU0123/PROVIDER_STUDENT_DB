import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/home_provider.dart';

class AddStudentProvider extends ChangeNotifier {
  File? studentImage;
  pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      studentImage = File(pickedImage.path);
    } else {
      // Clear the image if no image is picked
      studentImage = null;
    }
    notifyListeners();
  }

  void clearImage() {
    studentImage = null;
    notifyListeners();
  }

  saveData({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController ageController,
    required TextEditingController standardController,
    required TextEditingController placeController,
    required bool namevalidate,
    required bool agevalidate,
    required bool standardvalidate,
    required bool placevalidate,
  }) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    nameController.text.isEmpty ? namevalidate = false : namevalidate = true;
    ageController.text.isEmpty ? agevalidate = false : agevalidate = true;
    placeController.text.isEmpty ? placevalidate = false : placevalidate = true;
    standardController.text.isEmpty
        ? standardvalidate = false
        : standardvalidate = true;

    RegExp regExp = RegExp(r"^(0?[1-9]|[1-9][0-9]|[1][01][0-9]|120)$");
    RegExp stringRegExp = RegExp(r"^[^0-9,]*$");
    if (namevalidate &&
        agevalidate &&
        placevalidate &&
        standardvalidate &&
        regExp.hasMatch(ageController.text) &&
        stringRegExp.hasMatch(nameController.text) &&
        stringRegExp.hasMatch(placeController.text)) {
      var _student = StudentDataBaseModel();
      _student.profileimage = studentImage != null
          ? await File(studentImage!.path).readAsBytes()
          : null;
      _student.name = nameController.text;
      _student.age = ageController.text;
      _student.place = placeController.text;
      _student.standard = standardController.text;
      await homeProvider.dbService.addStudentToDB(_student);
      homeProvider.getAllStudentDetails();
      Navigator.pop(
        context,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(
            seconds: 2,
          ),
          content: TextWidgetCommon(
            color: kWhite,
            text: "Fill all fields correctly",
          ),
        ),
      );
    }
    notifyListeners();
  }
}
