import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String imageUrl;
  final String uid;
  final String token;
  UserModel({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      uid: map['uid'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? name,
    String? email,
    String? imageUrl,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
