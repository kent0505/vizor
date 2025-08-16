import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../models/auth.dart';

abstract interface class AuthRepository {
  const AuthRepository();

  bool isExpired();
  Future<void> sendCode(String phone);
  Future<void> login(
    String phone,
    String code,
  );
}

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required SharedPreferences prefs,
    required Dio dio,
  })  : _prefs = prefs,
        _dio = dio;

  final SharedPreferences _prefs;
  final Dio _dio;

  @override
  bool isExpired() {
    try {
      final token = _prefs.getString(Keys.token) ?? '';
      return getExpired(token);
    } catch (e) {
      logger(e);
      return true;
    }
  }

  @override
  Future<void> sendCode(String phone) async {
    final response = await _dio.post(
      '/api/v1/auth/send_code',
      data: {
        'phone': phone,
      },
    );

    if (response.statusCode == 200) return;

    throw Exception(response.data['detail']);
  }

  @override
  Future<void> login(
    String phone,
    String code,
  ) async {
    final response = await _dio.post(
      '/api/v1/auth/login',
      data: {
        'phone': phone,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      final auth = Auth.fromJson(response.data);
      await _prefs.setString(Keys.token, auth.token);
      await _prefs.setString(Keys.role, auth.role);
      return;
    }

    throw Exception(response.data['detail']);
  }
}
