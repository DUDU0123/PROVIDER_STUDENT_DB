import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_field_common_widget.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/enums/pagetype_enum.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({
    super.key,
    required this.pageType,
  });
  final PageTypeEnum pageType;
  final bool _namevalidate = true;
  final bool _agevalidate = true;
  final bool _placevalidate = true;
  final bool _standardvalidate = true;

  @override
  Widget build(BuildContext context) {
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
                // pageType == PageTypeEnum.addStudent
                //     ?
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
                TextFieldCommonWidget(
                  errorText: !_namevalidate ? "Name can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: addStudentProvider.nameController,
                  hintText: "Name",
                  labelText: "Enter name",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_agevalidate ? "Age can't be Empty" : null,
                  keyboardType: TextInputType.number,
                  nameController: addStudentProvider.ageController,
                  hintText: "Age",
                  labelText: "Enter age",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_placevalidate ? "Place can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: addStudentProvider.placeController,
                  hintText: "Place",
                  labelText: "Enter place",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_standardvalidate ? "Class can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: addStudentProvider.standardController,
                  hintText: "Class",
                  labelText: "Enter class",
                ),
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
                          namevalidate: _namevalidate,
                          agevalidate: _agevalidate,
                          standardvalidate: _standardvalidate,
                          placevalidate: _placevalidate,
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
