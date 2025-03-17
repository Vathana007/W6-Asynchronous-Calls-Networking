import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseScoreForm extends StatefulWidget {
  final String courseId;

  const CourseScoreForm({super.key, required this.courseId});

  @override
  State<CourseScoreForm> createState() => _CourseScoreFormState();
}

class _CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _studentId = '';
  String _studentName = '';
  double _studentScore = 50.0;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        CourseScore(studentId: _studentId, studentName: _studentName, studenScore: _studentScore),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Score')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Student ID'),
                onSaved: (value) => _studentId = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Student Name'),
                onSaved: (value) => _studentName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Score'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _studentScore = double.parse(value!),
              ),
              SizedBox(height: 12),
              ElevatedButton(onPressed: _saveItem, child: Text('Add Score')),
            ],
          ),
        ),
      ),
    );
  }
}