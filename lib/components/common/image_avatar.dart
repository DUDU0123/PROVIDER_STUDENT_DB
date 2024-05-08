import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/provider/edit_student_provider.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    super.key,
    required this.editStudentProvider,
    this.backgroundImage,
  });

  final EditStudentProvider editStudentProvider;
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      backgroundImage: backgroundImage,
      // const AssetImage(
      //   "assets/person.png",
      // ),
      child: IconButton(
        onPressed: () async {
          final pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            editStudentProvider.updateStudentImage(File(pickedImage.path));
          }
        },
        icon: Icon(
          Icons.camera_alt_outlined,
          size: 35,
          color: kWhite,
        ),
      ),
    );
  }
}