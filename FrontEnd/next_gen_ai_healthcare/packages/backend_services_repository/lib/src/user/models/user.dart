
import 'package:backend_services_repository/src/user/entities/entities.dart';

class User {
  final String userId;
  final String userName;
  final String email;
  final String password;
  String? picture;
  double? personReputation;
  Map<String, dynamic>? location;

  User({required this.userId, required this.userName, this.password="", required this.email, this.picture, this.location, this.personReputation=0});

  static UserEntity toEntity(User user){
    return UserEntity(userId: user.userId, password: user.password, userName: user.userName, email: user.email, picture:user.picture??"", location:user.location??{}, personReputation:user.personReputation);
  }

  static User fromEntity(UserEntity userEntity){
    return User(userId: userEntity.userId, userName: userEntity.userName, password: userEntity.password, email: userEntity.email, picture:userEntity.picture??"", location:userEntity.location??{}, personReputation:userEntity.personReputation);
  }

}
