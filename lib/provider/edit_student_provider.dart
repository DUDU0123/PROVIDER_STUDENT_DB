import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/home_provider.dart';

class EditStudentProvider extends ChangeNotifier {
  File? studentImage;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final standardController = TextEditingController();

  fetchAvailableData({required StudentDataBaseModel studentDataBaseModel}) {
    nameController.text = studentDataBaseModel.name ?? '';
    ageController.text = studentDataBaseModel.age ?? '';
    placeController.text = studentDataBaseModel.place ?? '';
    standardController.text = studentDataBaseModel.standard ?? '';
    notifyListeners();
  }

  void clearImage() {
    studentImage = null;
    notifyListeners();
  }

  pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      studentImage = File(pickedImage.path);
    }
    notifyListeners();
  }

  void clearAll() {
    nameController.text = '';
    ageController.text = '';
    placeController.text = '';
    standardController.text = '';
    notifyListeners();
  }

  saveData({
    required BuildContext context,
    required bool namevalidate,
    required bool agevalidate,
    required bool standardvalidate,
    required bool placevalidate,
    required StudentDataBaseModel studentModel,
  }) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    nameController.text.isEmpty ? namevalidate = false : namevalidate = true;
    ageController.text.isEmpty ? agevalidate = false : agevalidate = true;
    placeController.text.isEmpty ? placevalidate = false : placevalidate = true;
    standardController.text.isEmpty
        ? standardvalidate = false
        : standardvalidate = true;
    notifyListeners();
    RegExp regExp = RegExp(r"^(0?[1-9]|[1-9][0-9]|[1][01][0-9]|120)$");
    RegExp stringRegExp = RegExp(r"^[^0-9,]*$");
    if (namevalidate &&
        agevalidate &&
        placevalidate &&
        standardvalidate &&
        regExp.hasMatch(ageController.text) &&
        stringRegExp.hasMatch(nameController.text) &&
        stringRegExp.hasMatch(placeController.text)) {
      var student = StudentDataBaseModel();
      student.profileimage = studentImage != null
          ? studentImage!.readAsBytesSync()
          : studentModel.profileimage;
      student.name = nameController.text;
      student.age = ageController.text;
      student.place = placeController.text;
      student.standard = standardController.text;
      await homeProvider.dbService.updateStudentData(student);
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
