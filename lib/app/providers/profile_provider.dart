import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  // Profile data
  String _name = 'John Doe';
  String _email = 'johndoe@gmail.com';
  String _phone = '+1 234 567 890';
  String _location = 'New York, USA';
  String _bio = 'Property enthusiast & real estate investor.';

  // Getters
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get location => _location;
  String get bio => _bio;

  // Update profile
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String bio,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _location = location;
    _bio = bio;
    notifyListeners(); // ← tell UI to rebuild
  }
}
