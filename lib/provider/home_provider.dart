import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/service/db_servicer.dart';

class HomeProvider extends ChangeNotifier {
  List<StudentDataBaseModel> studentDataList = <StudentDataBaseModel>[];
  final dbService = DbServicer();
  HomeProvider() {
    getAllStudentDetails();
  }

  getAllStudentDetails() async {
    var students = await dbService.getAllStudentsFromDB();
    studentDataList = <StudentDataBaseModel>[];
    students.forEach((student) {
      var studentModel = StudentDataBaseModel();
      studentModel.id = student['id'];
      studentModel.name = student['name'];
      studentModel.age = student['age'];
      studentModel.place = student['place'];
      studentModel.standard = student['standard'];

      try {
        Uint8List? imageBytes = student['profileimage'];

        if (imageBytes != null) {
          studentModel.profileimage = imageBytes;
        }
      } catch (e) {
        // Handle decoding error
        print('Error decoding profile image: $e');
      }
      studentDataList.add(studentModel);
    });
    notifyListeners();
  }

  void searchStudents(String query) async {
    var students = await dbService
        .getOneStudentFromDbList(StudentDataBaseModel(name: query));
    if (students != null) {
      studentDataList = <StudentDataBaseModel>[];
      students.forEach(
        (student) {
          // Populate _studentDataList with search results
          var studentModel = StudentDataBaseModel();
          studentModel.id = student['id'];
          studentModel.name = student['name'];
          studentModel.age = student['age'];
          studentModel.place = student['place'];
          studentModel.standard = student['standard'];

          try {
            Uint8List? imageBytes = student['profileimage'];

            if (imageBytes != null) {
              studentModel.profileimage = imageBytes;
            }
          } catch (e) {
            // Handle decoding error
            print('Error decoding profile image: $e');
          }

          studentDataList.add(studentModel);

          notifyListeners();
        },
      );
    } else {
      // Clear the _studentDataList
      studentDataList.clear();
      notifyListeners();
    }
  }
}
