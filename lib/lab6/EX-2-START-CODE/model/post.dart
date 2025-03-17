class Post {
  final int id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  // Get data from json
   factory Post.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int);
    return Post(
      id: json['id'],
      title: json['title'] ?? "No Title",
      description: json['body'] ?? "No Description",
    );
  }
}
