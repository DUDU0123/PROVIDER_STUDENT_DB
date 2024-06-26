import 'package:flutter/material.dart';
import 'package:provider_student_db/components/common/student_data_row_widget.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/model/student_database_model.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key, required this.studentModel});
  final StudentDataBaseModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidgetCommon(
          text: "Student Profile",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight25,
              Center(
                child: Container(
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(offset: Offset(1, 1), blurRadius: 2), BoxShadow(offset: Offset(-1, -1), blurRadius: 2)],
                    //border: Border.all(color: kTeal, width: 5),
                  ),
                  child: studentModel.profileimage != null? CircleAvatar(
                    radius: 80,
                    backgroundImage: MemoryImage(studentModel.profileimage!),
                  ): const CircleAvatar(radius: 80,child: Icon(Icons.person, size: 80,),),
                ),
              ),
              kHeight20,
              StudentDataRowWidget(
                fieldName: "Name",
                text: studentModel.name ?? '',
              ),
              kHeight15,
              StudentDataRowWidget(
                fieldName: "Age",
                text: studentModel.age ?? '',
              ),
              kHeight15,
              StudentDataRowWidget(
                fieldName: "Place",
                text: studentModel.place ?? '',
              ),
              kHeight15,
              StudentDataRowWidget(
                fieldName: "Class",
                text: studentModel.standard ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
