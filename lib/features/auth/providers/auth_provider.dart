import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userEmailKey = 'userEmail';
  
  bool _isLoggedIn = false;
  String? _userEmail;
  
  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;
  
  // Initialize the auth state from SharedPreferences
  Future<void> initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    _userEmail = prefs.getString(_userEmailKey);
    notifyListeners();
  }
  
  // Register function
  Future<bool> register(String email, String password) async {
    // TODO: Implement actual registration logic here
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real app, this would create a new user account
      return await login(email, password); // Automatically log in after registration
    } catch (e) {
      return false;
    }
  }

  // Login function
  Future<bool> login(String email, String password) async {
    // TODO: Implement actual authentication logic here
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real app, validate credentials here
      if (email.isNotEmpty && password.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_isLoggedInKey, true);
        await prefs.setString(_userEmailKey, email);
        
        _isLoggedIn = true;
        _userEmail = email;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  // Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_userEmailKey);
    
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}