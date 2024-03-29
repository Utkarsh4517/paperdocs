import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String profileImg;
  final String uid;
  final String token;
  UserModel({
    required this.name,
    required this.email,
    required this.profileImg,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImg': profileImg,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImg: map['profileImg'] ?? '',
      uid: map['_id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? name,
    String? email,
    String? profileImg,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profileImg: profileImg ?? this.profileImg,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
