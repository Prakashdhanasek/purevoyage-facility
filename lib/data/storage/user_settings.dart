import 'dart:convert';

class UserSettings {
  static final UserSettings userSettings = UserSettings._privateConstructor();
  UserSettings._privateConstructor();

  factory UserSettings() {
    return userSettings;
  }
  String userID = '';
  String email = '';
  String role = '';

  Map<String, dynamic> toJson() => {'email': email, 'role': role, 'id': userID};

  UserSettings fromJson(Map<String, dynamic> json) {
    UserSettings().email = json['email'] ?? '';
    UserSettings().role = json['role'] ?? '';
    UserSettings().userID = json['id'] ?? '';

    return UserSettings.userSettings;
  }

  UserSettings fromJsonString(String str) {
    return str.isEmpty ? UserSettings() : fromJson(json.decode(str));
  }

  String toJsonString() => json.encode(userSettings.toJson());
}
