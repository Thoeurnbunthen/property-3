class AuthService {
  // Simulate API call - replace with real API (dio/http)
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // fake delay

    // ✅ Replace this with real API call
    if (email == 'test@gmail.com' && password == '123456') {
      return {
        'success': true,
        'user': {'id': '1', 'name': 'John', 'email': email},
      };
    }
    return {'success': false, 'message': 'Invalid credentials'};
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2)); // fake delay

    // ✅ Replace this with real API call
    return {
      'success': true,
      'user': {'id': '2', 'name': name, 'email': email},
    };
  }
}
