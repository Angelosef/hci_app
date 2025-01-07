class Settings {
  final int userId;
  final bool notificationsEnabled;

  Settings({
    required this.userId,
    required this.notificationsEnabled,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      userId: json['user_id'],
      notificationsEnabled: json['notifications_enabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'notifications_enabled': notificationsEnabled,
    };
  }
}
