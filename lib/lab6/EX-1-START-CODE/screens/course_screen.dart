import 'package:flutter/material.dart';
import 'package:lab_week6/lab6/EX-1-START-CODE/screens/course_list_screen.dart';
import 'package:provider/provider.dart';
import '../providers/courses_provider.dart';
import '../models/course.dart';
import 'course_score_form.dart';

class CourseScreen extends StatefulWidget {
  final String courseId;

  const CourseScreen({super.key, required this.courseId});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<CourseScore> get scores => context.read<CoursesProvider>().getCourseFor(widget.courseId).scores;

  void _addScore() async {
    final newScore = await Navigator.push<CourseScore>(
      context,
      MaterialPageRoute(
        builder: (context) => CourseScoreForm(courseId: widget.courseId),
      ),
    );

    if (newScore != null) {
      setState(() {
        context.read<CoursesProvider>().addScore(widget.courseId, newScore);
      });
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    final course = context.watch<CoursesProvider>().getCourseFor(widget.courseId);

    Widget content = const Center(child: Text('No Scores added yet.'));

    if (course.scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: course.scores.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(course.scores[index].studentName),
          trailing: Text(
            course.scores[index].studenScore.toString(),
            style: TextStyle(
              color: scoreColor(course.scores[index].studenScore),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: _addScore, icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
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