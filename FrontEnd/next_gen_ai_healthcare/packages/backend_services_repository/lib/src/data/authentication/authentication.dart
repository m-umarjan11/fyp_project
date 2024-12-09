import 'dart:convert';

import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:backend_services_repository/src/user/entities/entities.dart';
import 'package:http/http.dart' as http;

abstract class Authentication {
  Future<bool> checkUserAccountOnStartUp(); 
  Future<Result<User, String>> createAnAccount({required User user, required String password}); 
  Future<void> saveAccountLocally({required User user});
  Future<Result<User, String>> login({required String email, required String password}); 
  Future<void> logout(); 
}

class AuthenticationImp extends Authentication {
  @override
  Future<bool> checkUserAccountOnStartUp() async {
    bool checkUser = await LocalUserData().checkUser();
    return checkUser;
  }

  @override
  Future<Result<User, String>> createAnAccount({required User user, required String password}) async {
    Uri url = Uri.parse("$api/users/register");
    Map<String, dynamic> toSend = UserEntity.toJson(User.toEntity(user));
    toSend['password'] = password;

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(toSend),
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      User updatedUser = User.fromEntity(UserEntity.fromJson(responseBody));
      LocalUserData().insertUser(updatedUser);
      return Result.success(updatedUser);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final responseBody = json.decode(response.body);
      return Result.failure("responseBody['msg']");
    } else {
      return Result.failure('An unexpected error occurred.');
    }
  }

  @override
  Future<void> saveAccountLocally({required User user}) async {
    await LocalUserData().insertUser(user);
  }

  @override
  Future<Result<User, String>> login({required String email, required String password}) async {
    Uri url = Uri.parse("$api/users/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      User loggedInUser = User.fromEntity(UserEntity.fromJson(responseBody));
      await saveAccountLocally(user: loggedInUser);
      return Result.success(loggedInUser);
    } else if (response.statusCode >= 400 && response.statusCode < 600) {
      final responseBody = json.decode(response.body);
      return Result.failure(responseBody['msg']);
    } else {
      return Result.failure("An unexpected error occurred.");
    }
  }

  @override
  Future<void> logout() async {
    await LocalUserData().clearUserTable();
  }
}
