import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/home_provider.dart';

class AddStudentProvider extends ChangeNotifier {

  File? studentImage;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final standardController = TextEditingController();
     bool namevalidate = true;
   bool agevalidate = true;
   bool placevalidate = true;
   bool standardvalidate = true;

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

  void clearAll() {
    clearImage();
    nameController.text = '';
    ageController.text = '';
    placeController.text = '';
    standardController.text = '';
    notifyListeners();
  }

  void clearImage() {
    studentImage = null;
    notifyListeners();
  }

  saveData({
    required BuildContext context,
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
          ? await File(studentImage!.path).readAsBytes()
          : null;
      student.name = nameController.text;
      student.age = ageController.text;
      student.place = placeController.text;
      student.standard = standardController.text;
      await homeProvider.dbService.addStudentToDB(student);
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
