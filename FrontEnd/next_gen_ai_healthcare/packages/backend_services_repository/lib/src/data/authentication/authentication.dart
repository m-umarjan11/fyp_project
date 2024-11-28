import 'dart:convert';
import 'dart:io';

import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:backend_services_repository/src/user/entities/entities.dart';

abstract class Authentication {
  Future<bool> checkUserAccountOnStartUp(); // If null then login, otherwise check if user has an account
  Future<Result<User, String>> createAnAccount({required User user}); // Return error msg and User
  Future<void> saveAccountLocally({required User user});
  Future<Result<User, String>> login({required String email, required String password}); // Login with email/password
  Future<void> logout(); // Logout and clear local data
}

class AuthenticationImp extends Authentication {
  HttpClient http = HttpClient();

  @override
  Future<bool> checkUserAccountOnStartUp() async {
    bool checkUser = await SqlHelper().checkUser();
    return checkUser;
  }

  @override
  Future<Result<User, String>> createAnAccount({required User user}) async {
    Uri url = Uri.parse("$api/users/register");
    HttpClientRequest request = await http.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    request.write(UserEntity.toJson(User.toEntity(user)));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 201) {
      String responseBody = await response.transform(utf8.decoder).join();
      User updatedUser = User.fromEntity(UserEntity.fromJson(responseBody));
      return Result.success(updatedUser);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      String msg =
          json.decode(await response.transform(utf8.decoder).join())['msg'];
      return Result.failure(msg);
    } else {
      return Result.failure('An unexpected error occurred.');
    }
  }

  @override
  Future<void> saveAccountLocally({required User user}) async {
    await SqlHelper().insertUser(user);
  }

  @override
  Future<Result<User, String>> login({required String email, required String password}) async {
    Uri url = Uri.parse("$api/users/login");
    HttpClientRequest request = await http.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    request.write(json.encode({"email": email, "password": password}));

    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      User loggedInUser = User.fromEntity(UserEntity.fromJson(responseBody));
      await saveAccountLocally(user: loggedInUser); // Save user locally
      return Result.success(loggedInUser);
    } else if (response.statusCode == 401) {
      return Result.failure("Invalid credentials");
    } else {
      return Result.failure("An unexpected error occurred.");
    }
  }

  @override
  Future<void> logout() async {
    await SqlHelper().clearUserTable(); // Clear user data from SQLite
  }
}
