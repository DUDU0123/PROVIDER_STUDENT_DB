import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import 'package:provider_student_db/views/add_edit/add_student_page.dart';

class AddStudentButtonHome extends StatelessWidget {
  const AddStudentButtonHome({
    super.key,
    required this.homeProvider,
  });

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    final addStudentProvider = Provider.of<AddStudentProvider>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: kBlack,
      onPressed: () {
        addStudentProvider.clearImage();
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddStudent(),
          ),
        );
        //     .then((value) {
        //   if (value != null) {
        //     homeProvider.getAllStudentDetails();
        //     showSnackbarAfterDataFetch(
        //       context: context,
        //       text: "Data Successfully Saved",
        //     );
        //   }
        // });
      },
      child: Icon(
        Icons.add,
        size: 30,
        color: kWhite,
      ),
    );
  }
}