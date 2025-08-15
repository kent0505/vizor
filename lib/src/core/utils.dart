import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

void logger(Object message) => developer.log(message.toString());

Options getAuthorizationOptions(SharedPreferences prefs) {
  return Options(headers: {
    'Authorization': 'Bearer ${prefs.getString(Keys.token) ?? ''}',
  });
}

bool getExpired(String token) {
  final parts = token.split('.');
  if (parts.length != 3) throw Exception('Invalid JWT');
  final payload = parts[1];
  final normalized = base64Url.normalize(payload);
  final payloadBytes = base64Url.decode(normalized);
  final payloadString = utf8.decode(payloadBytes);
  final payloadMap = jsonDecode(payloadString) as Map<String, dynamic>;
  if (!payloadMap.containsKey('exp')) {
    throw Exception('JWT does not contain exp field');
  }
  return DateTime.now().isAfter(
    DateTime.fromMillisecondsSinceEpoch((payloadMap['exp'] as int) * 1000),
  );
}

extension FirstWhereOrNullExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
