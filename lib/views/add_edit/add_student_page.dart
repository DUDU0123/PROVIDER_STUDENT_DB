import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/components/common/textfields_widget.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/enums/pagetype_enum.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/edit_student_provider.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({
    super.key,
    required this.pageType,
  });
  final PageTypeEnum pageType;

  @override
  Widget build(BuildContext context) {
    final editStudentProvider = Provider.of<EditStudentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const TextWidgetCommon(
          text: "Student Record",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
      body: Consumer<AddStudentProvider>(
        builder: (context, addStudentProvider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 214, 255, 251),
                  radius: 60,
                  backgroundImage: addStudentProvider.studentImage != null
                      ? FileImage(addStudentProvider.studentImage!)
                      : null,
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        addStudentProvider.pickImageFromGallery();
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 35,
                        color: kBlack,
                      ),
                    ),
                  ),
                ),
                TextWidgetCommon(
                  text: "Add New Student",
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                kHeight15,
                TextFieldsWidget(
                    editStudentProvider: editStudentProvider,
                    addStudentProvider: addStudentProvider,
                    pageType: pageType,),
                kHeight15,
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () async {
                        final addStudentProvider =
                            Provider.of<AddStudentProvider>(
                          context,
                          listen: false,
                        );
                        addStudentProvider.saveData(
                          context: context,
                        );
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
                        addStudentProvider.clearImage();
                        addStudentProvider.clearAll();
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
