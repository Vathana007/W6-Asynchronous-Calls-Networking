import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/courses_provider.dart';
import '../models/course.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  final String courseId;

  const CourseScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final course = context.watch<CoursesProvider>().getCourseFor(courseId);

    return Scaffold(
      appBar: AppBar(title: Text(course.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: course.scores.length,
              itemBuilder: (context, index) => ScoreTile(score: course.scores[index]),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final newScore = await Navigator.push<CourseScore>(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseScoreForm(courseId: courseId),
                ),
              );
              if (newScore != null) {
                context.read<CoursesProvider>().addScore(courseId, newScore);
              }
            },
            child: Text('Add Score'),
          ),
        ],
      ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  final CourseScore score;

  const ScoreTile({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Student: ${score.studentName}'),
      subtitle: Text('Score: ${score.studenScore}'),
    );
  }
}