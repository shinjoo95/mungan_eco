class Post {
  String userId;
  String title;
  String imageUrl;
  String id;

  Post({required this.userId, required this.title, required this.imageUrl, required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
