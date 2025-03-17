import 'package:lab_week6/lab6/EX-1-START-CODE/models/course.dart';
import 'package:lab_week6/lab6/EX-1-START-CODE/repositories/courses_repository.dart';

class MockCoursesRepository implements CoursesRepository {
  final List<Course> _courses = [
    Course(id: '1', name: 'HTML', scores: []),
    Course(id: '2', name: 'JAVA', scores: []),
  ];

  @override
  List<Course> getCourses() => _courses;

  @override
  void addScore(Course course, CourseScore score) {
    course.scores.add(score);
  }
}