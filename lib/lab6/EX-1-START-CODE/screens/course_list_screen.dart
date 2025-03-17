import 'package:flutter/material.dart';
import 'package:lab_week6/lab6/EX-1-START-CODE/providers/courses_provider.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final List<Course> _allCourses = [
    Course(
      id: '1',
      name: 'HTML',
      scores: [
        CourseScore(studentId: '1', studentName: 'John', studenScore: 50),
      ],
    ),
    Course(
      id: '2',
      name: 'JAVA',
      scores: [
        CourseScore(studentId: '2', studentName: 'Alice', studenScore: 60),
      ],
    ),
  ];

  Future<void> _editCourse(Course course) async {
    final updatedCourse = await Navigator.of(context).push<Course>(
      MaterialPageRoute(builder: (ctx) => CourseScreen(courseId: course.id)),
    );

    if (updatedCourse != null) {
      setState(() {
        final index = _allCourses.indexWhere((c) => c.id == updatedCourse.id);
        if (index != -1) {
          _allCourses[index] = updatedCourse;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<CoursesProvider>(
        builder: (context, provider, child) {
          final courses = provider.courses;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (ctx, index) {
              final course = courses[index];
              return Dismissible(
                key: Key(course.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  provider.courses.removeAt(index);
                  provider.notifyListeners();
                },
                child: CourseTile(
                  course: course,
                  onEdit: (course) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseScreen(courseId: course.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course),
            title: Text(
              course.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(numberText, style: TextStyle(color: Colors.black54)),
                Text(averageText, style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
