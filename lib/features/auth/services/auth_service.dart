import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class AuthService {
  final ApiClient client;

  AuthService(this.client);

  // ---------------------------------------------------------
  // REGISTER USER
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      ApiEndpoints.registerUser,
      data: {
        "email": email,
        "password": password,
      },
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
    
      return body;
      // Expected: { success, message, userId }
    }

    throw Exception("Unexpected register response: $body");
  }

  // ---------------------------------------------------------
  // LOGIN USER
  // ---------------------------------------------------------
Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {
  final response = await client.post(
    ApiEndpoints.loginUser,
    data: {
      "email": email,
      "password": password,
    },
  );

  final body = response.data;

 
  if (body == null ||
      body["data"] == null ||
      body["data"]["accessToken"] == null ||
      body["data"]["refreshToken"] == null ||
      body["data"]["user"] == null) {
    throw Exception("Invalid login response format");
  }

  
  final token = body["data"]["accessToken"];
  final refreshToken = body["data"]["refreshToken"];
  final user = body["data"]["user"]; // FULL user object

 
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('refreshToken', refreshToken);

 
  ApiClient().updateToken(token);

  return {
    "success": body["success"],
    "message": body["message"],
    "user": user, // return user if needed
  };
}


 
  Future<Map<String, dynamic>> verifyOtp({
    required String userId,
    required String otp,
  }) async {
    final response = await client.post(
      ApiEndpoints.verifyOtp,
      data: {
        "userId": userId,
        "otp": otp,
      },
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body;
      // Expected: { success: true, verified: true }
    }

    throw Exception("Unexpected OTP verification response: $body");
  }

  // ---------------------------------------------------------
  // SEND RESET PASSWORD OTP (email only)
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> sendResetPasswordOtp(String email) async {
    final response = await client.post(
      ApiEndpoints.sendResetPasswordOtp,
      data: {
        "email": email,
      },
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body;
      // Expected: { success, userId, message }
    }

    throw Exception("Unexpected reset-password otp response: $body");
  }

  // ---------------------------------------------------------
  // RESET PASSWORD (userId + OTP + new password)
  // ---------------------------------------------------------
  Future<Map<String, dynamic>> resetPassword({
    required String userId,
    required String otp,
    required String newPassword,
  }) async {
    final response = await client.post(
      ApiEndpoints.resetPassword,
      data: {
        "userId": userId,
        "otp": otp,
        "newPassword": newPassword,
      },
    );

    final body = response.data;

    if (body is Map<String, dynamic>) {
      return body;
      // Expected: { success, message }
    }

    throw Exception("Unexpected reset-password response: $body");
  }
}
