import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? passportData;
  final String? role;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.passportData,
    this.role,
  });
}

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  // Mock login - in real app, call API
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock user for demo
    _user = User(
      id: 1,
      email: email,
      firstName: 'Иван',
      lastName: 'Иванов',
      passportData: 'AB1234567',
    );
    notifyListeners();
    return true;
  }

  // Mock register - in real app, call API
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? passportData,
  }) async {
    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      return false;
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _user = User(
      id: 1,
      email: email,
      firstName: firstName,
      lastName: lastName,
      passportData: passportData,
    );
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
