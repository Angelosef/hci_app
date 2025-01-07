class Clue {
  final int id;
  final String description;
  final String imageUrl;
  final String location;
  final double latitude;
  final double longitude;

  Clue({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory Clue.fromJson(Map<String, dynamic> json) {
    return Clue(
      id: json['clue_id'],
      description: json['description'],
      location: json['location'],
      imageUrl: json['image_url'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clue_id': id,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
