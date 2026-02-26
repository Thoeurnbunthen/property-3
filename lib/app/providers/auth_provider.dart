import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  UserModel? currentUser;
  bool isLoading = false;
  String? errorMessage;

  // ── LOGIN ──
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await _repo.login(email, password);
      isLoading = false;
      notifyListeners();
      return true; // success
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false; // failed
    }
  }

  // ── REGISTER ──
  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentUser = await _repo.register(name, email, password);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ── LOGOUT ──
  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
