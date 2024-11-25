import 'dart:convert';

class UserEntity {
  final String userId;
  final String userName;
  final String email;
  String? picture;
  double? personReputation;
  Map<String, dynamic>? location;

  UserEntity(
      {required this.userId,
      required this.userName,
      required this.email,
      this.picture,
      this.location,
      this.personReputation = 0});

  UserEntity fromJson(String jsonString) {
    Map<String, dynamic> jsonObject = json.decode(jsonString);
    return UserEntity(
      userId: jsonObject['userId'],
      userName: jsonObject['userName'],
      email: jsonObject['email'],
      picture: jsonObject['picture'],
      personReputation: jsonObject['personReputation'],
      location: jsonObject['location'],
    );
  }

  Map<String, dynamic> toJson(UserEntity userEntity) {
    return {
      'userId': userEntity.userId,
      'userName': userEntity.userName,
      'email': userEntity.email,
      'picture': userEntity.picture,
      'personReputation': userEntity.personReputation,
      'location': userEntity.location,
    };
  }
}
