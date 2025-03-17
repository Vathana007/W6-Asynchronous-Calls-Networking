import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/courses_repository.dart';

class CoursesProvider with ChangeNotifier {
  final CoursesRepository repository;
  List<Course> _courses = [];

  CoursesProvider(this.repository) {
    _courses = repository.getCourses();
  }

  List<Course> get courses => _courses;

  Course getCourseFor(String courseId) {
    return _courses.firstWhere((course) => course.id == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    getCourseFor(courseId).scores.add(score);
    notifyListeners();
  }
}
