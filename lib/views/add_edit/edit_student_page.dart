import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_field_common_widget.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/model/student_database_model.dart';
import 'package:provider_student_db/provider/edit_student_provider.dart';

class EditStudentProfilePage extends StatelessWidget {
  const EditStudentProfilePage({super.key, required this.studentModel});
  final StudentDataBaseModel studentModel;
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
      body: Consumer<EditStudentProvider>(
        builder: (context, editStudentProvider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                studentModel.profileimage != null ||
                        editStudentProvider.studentImage != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            editStudentProvider.studentImage != null
                                ? MemoryImage(editStudentProvider.studentImage!
                                    .readAsBytesSync())
                                : MemoryImage(studentModel.profileimage!),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              editStudentProvider.pickImageFromGallery();
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                              color: kBlack,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: const AssetImage(
                          "assets/person.png",
                        ),
                        child: IconButton(
                          onPressed: () async {
                            editStudentProvider.pickImageFromGallery();
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                            color: kWhite,
                          ),
                        ),
                      ),
                TextWidgetCommon(
                  text: "Edit Student Details",
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_namevalidate ? "Name can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentProvider.nameController,
                  hintText: "Name",
                  labelText: "Enter name",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_agevalidate ? "Age can't be Empty" : null,
                  keyboardType: TextInputType.number,
                  nameController: editStudentProvider.ageController,
                  hintText: "Age",
                  labelText: "Enter age",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_placevalidate ? "Place can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentProvider.placeController,
                  hintText: "Place",
                  labelText: "Enter place",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !_standardvalidate ? "Class can't be Empty" : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentProvider.standardController,
                  hintText: "Class",
                  labelText: "Enter class",
                ),
                kHeight15,
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () async {
                        final editStudentProvider =
                            Provider.of<EditStudentProvider>(
                          context,
                          listen: false,
                        );
                        editStudentProvider.saveData(
                          studentModel: studentModel,
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
                        editStudentProvider.clearImage();
                        editStudentProvider.clearAll();
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
