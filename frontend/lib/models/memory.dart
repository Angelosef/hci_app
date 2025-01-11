class Memory {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String imageUrl;
  final double latitude;
  final double longitude;

  Memory({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create a Memory from JSON
  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      id: json['memory_id'],
      userId: json['user_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  // Convert Memory to JSON (useful for API requests)
  Map<String, dynamic> toJson() {
    return {
      'memory_id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}