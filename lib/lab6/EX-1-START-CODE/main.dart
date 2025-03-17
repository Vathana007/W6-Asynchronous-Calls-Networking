import 'package:flutter/material.dart';
import 'package:lab_week6/lab6/EX-1-START-CODE/repositories/courses_mock_repository.dart';
import 'package:provider/provider.dart';
import 'providers/courses_provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoursesProvider(MockCoursesRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Course Score App',
      // theme: ThemeData(primarySwatch: Colors.blue),
      home: const CourseListScreen(),
    );
  }
}