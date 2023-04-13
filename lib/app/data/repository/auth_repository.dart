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
      UserResponse res = UserResponse.fromJson(result);

      if ((res.message ?? '').contains('user tidak ditemukan')) {
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

  Future<bool> registerUser({required UserBody userBody}) async {
    try {
      final result =
          await dioClient.post(Urls.userRegister, body: userBody.toMap());

      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Err registerUser: $e, $stackTrace');
      }
      return false;
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
