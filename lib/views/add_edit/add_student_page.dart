import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/text_field_common_widget.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({
    super.key,
  });

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _standardController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Consumer<AddStudentProvider>(
                builder: (context, addStudentProvider, child) => CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 214, 255, 251),
                  radius: 60,
                  backgroundImage: addStudentProvider.studentImage != null
                      ? FileImage(addStudentProvider.studentImage!)
                      : null,
                  child: Center(
                    child: addStudentProvider.studentImage != null
                        ? null
                        : IconButton(
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
                nameController: _nameController,
                hintText: "Name",
                labelText: "Enter name",
              ),
              kHeight15,
              TextFieldCommonWidget(
                errorText: !_agevalidate ? "Age can't be Empty" : null,
                keyboardType: TextInputType.number,
                nameController: _ageController,
                hintText: "Age",
                labelText: "Enter age",
              ),
              kHeight15,
              TextFieldCommonWidget(
                errorText: !_placevalidate ? "Place can't be Empty" : null,
                keyboardType: TextInputType.text,
                nameController: _placeController,
                hintText: "Place",
                labelText: "Enter place",
              ),
              kHeight15,
              TextFieldCommonWidget(
                errorText: !_standardvalidate ? "Class can't be Empty" : null,
                keyboardType: TextInputType.text,
                nameController: _standardController,
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
                          Provider.of<AddStudentProvider>(context,
                              listen: false);
                      addStudentProvider.saveData(
                        context: context,
                        nameController: _nameController,
                        ageController: _ageController,
                        standardController: _standardController,
                        placeController: _placeController,
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
                      final addStudentProvider =
                          Provider.of<AddStudentProvider>(context,
                              listen: false);
                      addStudentProvider.clearImage();
                      _nameController.text = '';
                      _ageController.text = '';
                      _placeController.text = '';
                      _standardController.text = '';
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
    );
  }
}
