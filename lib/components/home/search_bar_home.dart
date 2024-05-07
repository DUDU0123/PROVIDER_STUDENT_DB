import 'package:flutter/material.dart';
import 'package:provider_student_db/constants/colors/colors.dart';
import 'package:provider_student_db/provider/home_provider.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
    required this.searchValueController, required this.homeProvider,
  });

  final TextEditingController searchValueController;
  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(
        bottom: 30,
        left: 30,
        right: 30,
      ),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(217, 195, 195, 195),
      ),
      child: TextField(
        onChanged: (searchedWord) {
          homeProvider.searchStudents(searchedWord);
        },
        controller: searchValueController,
        style: TextStyle(
          color: kBlack,
          fontSize: 21,
        ),
        cursorColor: kBlack,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10),
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTransparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTransparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTransparent,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kTransparent,
            ),
          ),
        ),
      ),
    );
  }
}