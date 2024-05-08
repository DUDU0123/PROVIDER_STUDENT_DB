import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/enums/pagetype_enum.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import 'package:provider_student_db/views/add_edit/add_student_page.dart';

class AddStudentButtonHome extends StatelessWidget {
  const AddStudentButtonHome({
    super.key,
    required this.homeProvider, this.studentModel,
  });

  final HomeProvider homeProvider;
  final StudentDataBaseModel? studentModel;

  @override
  Widget build(BuildContext context) {
    final addStudentProvider = Provider.of<AddStudentProvider>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: kBlack,
      onPressed: () {
        addStudentProvider.clearImage();
        addStudentProvider.clearAll();
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddStudent(pageType: PageTypeEnum.addStudent,),
          ),
        );
      },
      child: Icon(
        Icons.add,
        size: 30,
        color: kWhite,
      ),
    );
  }
}