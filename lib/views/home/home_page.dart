import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/components/common/no_student_widget.dart';
import 'package:provider_student_db/components/common/text_widget_common.dart';
import 'package:provider_student_db/components/delete_dialog.dart';
import 'package:provider_student_db/components/home/add_student_button_home.dart';
import 'package:provider_student_db/components/home/search_bar_home.dart';
import 'package:provider_student_db/components/snackbar.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/constants/height_width/height_width.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import 'package:provider_student_db/views/add_edit/edit_student_page.dart';
import 'package:provider_student_db/views/profile/student_profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final searchValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextWidgetCommon(
            text: "Student Record",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: SearchBarHome(
              searchValueController: searchValueController,
              homeProvider: homeProvider,
            ),
          ),
        ),
        body: homeProvider.studentDataList.isEmpty
            ? const NoStudentWidget()
            : ListView.separated(
                itemCount: homeProvider.studentDataList.length,
                separatorBuilder: (context, index) => kHeight10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: kBlackOpacity,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentProfilePage(
                              studentModel:
                                  homeProvider.studentDataList[index]),
                        ),
                      );
                    },
                    leading:
                        homeProvider.studentDataList[index].profileimage != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(homeProvider
                                    .studentDataList[index].profileimage!),
                              )
                            : const CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                    title: TextWidgetCommon(
                      overflow: TextOverflow.ellipsis,
                      text: homeProvider.studentDataList[index].name ?? '',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => EditStudentProfilePage(
                                  studentModel:
                                      homeProvider.studentDataList[index],
                                ),
                              ),
                            )
                                .then(
                              (value) {
                                if (value != null) {
                                  homeProvider.getAllStudentDetails();
                                  showSnackbarAfterDataFetch(
                                    context: context,
                                    text: "Data Successfully Saved",
                                  );
                                }
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: kBlack,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteAlertDialog(
                              context: context,
                              userId: homeProvider.studentDataList[index].id,
                            );
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: kBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: AddStudentButtonHome(homeProvider: homeProvider),
      ),
    );
  }
}
