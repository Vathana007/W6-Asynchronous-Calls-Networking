class PostDTO {
  final int id;
  final String title;
  final String description;

  PostDTO({required this.id, required this.title, required this.description});

  // Get data from json
   factory PostDTO.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int);
    return PostDTO(
      id: json['id'],
      title: json['title'] ?? "No Title",
      description: json['body'] ?? "No Description",
    );
  }
}
