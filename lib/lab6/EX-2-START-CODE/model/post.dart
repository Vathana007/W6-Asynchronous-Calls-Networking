import 'package:lab_week6/lab6/EX-2-START-CODE/dto/post_dto.dart';

class Post {
  final int id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  // Get data from json
  factory Post.fromDTO(PostDTO dto) {
    return Post(
      id: dto.id,
      title: dto.title,
      description: dto.description,
    );
  }
}
