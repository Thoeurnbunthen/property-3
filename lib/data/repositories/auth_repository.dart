import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<UserModel?> register(
    String fullname,
    String username,
    String phonenumber,
    String email,
    String password,
  ) async {
    final result = await _service.register(
      fullname,
      username,
      phonenumber,
      email,
      password,
    );
    if (result['success']) {
      return UserModel.fromJson(result['user']);
    }
    throw Exception(result['message']);
  }

  // Future<UserModel?> register(
  //   String name,
  //   String email,
  //   String password,
  // ) async {
  //   final result = await _service.register(name, email, password);
  //   if (result['success']) {
  //     return UserModel.fromJson(result['user']);
  //   }
  //   throw Exception('Register failed');
  // }
}
