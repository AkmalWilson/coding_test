class Post {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
