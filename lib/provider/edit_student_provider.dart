import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider_student_db/model/student_database_model.dart';

class EditStudentProvider extends ChangeNotifier {
  File? studentImage;

  void updateStudentImage(File? newImage) {
    studentImage = newImage;
    notifyListeners();
  }
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final standardController = TextEditingController();
  bool namevalidate = true;
  bool agevalidate = true;
  bool placevalidate = true;
  bool standardvalidate = true;
  fetchAvailableData({
    required StudentDataBaseModel studentDataBaseModel,
    required Uint8List? uintStudentImage,
  }) {
    nameController.text = studentDataBaseModel.name ?? '';
    ageController.text = studentDataBaseModel.age ?? '';
    placeController.text = studentDataBaseModel.place ?? '';
    standardController.text = studentDataBaseModel.standard ?? '';
    // Convert Uint8List to File if profileImageBytes is not null
    if (uintStudentImage != null) {
      // Write bytes to a temporary file
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp_image.png');
      tempFile.writeAsBytesSync(uintStudentImage);

      // Assign the File object to studentImage
      studentImage = tempFile;
    }
    notifyListeners();
  }

  void clearAll() {
    nameController.text = '';
    ageController.text = '';
    placeController.text = '';
    standardController.text = '';
    // Set studentImage to null
    studentImage = null;
    notifyListeners();
  }

  saveData({
    required BuildContext context,
    required StudentDataBaseModel studentModel,
  }) async {
    //final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    nameController.text.isEmpty ? namevalidate = false : namevalidate = true;
    ageController.text.isEmpty ? agevalidate = false : agevalidate = true;
    placeController.text.isEmpty ? placevalidate = false : placevalidate = true;
    standardController.text.isEmpty
        ? standardvalidate = false
        : standardvalidate = true;
    notifyListeners();
  }
}
