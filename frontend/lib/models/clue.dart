class Clue {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String location;
  final double? latitude;
  final double? longitude;

  Clue({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.location,
    this.latitude,
    this.longitude,
  });

  factory Clue.fromJson(Map<String, dynamic> json) {
    return Clue(
      id: json['clue_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['image_url'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clue_id': id,
      'title': title,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
