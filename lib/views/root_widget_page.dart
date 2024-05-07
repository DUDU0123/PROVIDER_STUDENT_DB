import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_db/provider/add_student_provider.dart';
import 'package:provider_student_db/provider/home_provider.dart';
import 'package:provider_student_db/views/home/home_page.dart';

class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddStudentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 116, 113, 116),
          ),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
