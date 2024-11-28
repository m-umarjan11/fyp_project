
import 'package:backend_services_repository/src/user/entities/entities.dart';

class User {
  final String userId;
  final String userName;
  final String email;
  String? picture;
  double? personReputation;
  Map<String, dynamic>? location;

  User({required this.userId, required this.userName, required this.email, this.picture, this.location, this.personReputation=0});

  static UserEntity toEntity(User user){
    return UserEntity(userId: user.userId, userName: user.userName, email: user.email, picture:user.picture??"", location:user.location??{}, personReputation:user.personReputation);
  }

  static User fromEntity(UserEntity userEntity){
    return User(userId: userEntity.userId, userName: userEntity.userName, email: userEntity.email, picture:userEntity.picture??"", location:userEntity.location??{}, personReputation:userEntity.personReputation);
  }

}
