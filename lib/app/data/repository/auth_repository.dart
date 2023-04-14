import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lms/app/core/values/urls.dart';
import 'package:lms/app/data/models/user.dart';
import 'package:lms/app/data/services/dio_client.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository(this.dioClient);

  Future<UserData?> getUserByEmail({required String email}) async {
    try {
      final result =
          await dioClient.get(Urls.users, queryParameters: {'email': email});
      print(result);
      UserResponse res = UserResponse.fromJson(result);

      if (result['status'] != 1) {
        return null;
      }
      return res.data;
    } catch (e, stackTree) {
      if (kDebugMode) {
        print('Err getUserByEmail: $e, $stackTree');
      }

      return null;
    }
  }

  Future<UserData?> registerUser({required UserBody userBody}) async {
    try {
      final result =
          await dioClient.post(Urls.userRegister, body: userBody.toMap());
      UserResponse res = UserResponse.fromJson(result);
      return res.data;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err registerUser: $e, $stackTrace');
      }
      return null;
    }
  }

  Future<bool> updateUser({required UserBody userBody}) async {
    try {
      final result =
          await dioClient.post(Urls.userUpdate, body: userBody.toMap());

      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err registerUser: $e, $stackTrace');
      }
      return false;
    }
  }
}
