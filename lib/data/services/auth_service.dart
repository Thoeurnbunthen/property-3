import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  Future<Map<String, dynamic>> register(
    String fullname,
    String username,
    String phnoenumber,
    String email,
    String password,
  ) async {
    final response = await _dio.post(
      '/api/auth/register',
      data: {
        'fullname': fullname,
        'username': username,
        'phonenumber': phnoenumber,
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  // Future<Map<String, dynamic>> register(
  //   String name,
  //   String email,
  //   String password,
  // ) async {
  //   await Future.delayed(const Duration(seconds: 2)); // fake delay

  //   // ✅ Replace this with real API call
  //   return {
  //     'success': true,
  //     'user': {'id': '2', 'name': name, 'email': email},
  //   };
  // }
}
