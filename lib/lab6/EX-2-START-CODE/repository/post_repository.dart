import '../model/post.dart';

abstract class PostRepository {
  Future<Post> getPost(int postId);
  
  // Got list to return multiple posts
  Future<List<Post>> getPosts();
}
