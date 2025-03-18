import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab_week6/lab6/EX-2-START-CODE/dto/post_dto.dart';
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostsRepository implements PostRepository {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  @override
  Future<Post> getPost(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl/$postId'));

    if (response.statusCode == 200) {
      return Post.fromDTO(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load post");
    }
  }

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Post.fromDTO(PostDTO.fromJson(json))).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
