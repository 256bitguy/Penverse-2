import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;
  String? _token;

  // Singleton
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  /// Initialize Dio
  void init({required String baseUrl, String? token}) {
    _token = token;
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      ),
    );

    // Interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Update Authorization header dynamically
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          // print('➡️ Request: ${options.method} ${options.uri}');
          // print('Headers: ${options.headers}');
          // print('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print('✅ Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // print('❌ Error: ${e.response?.statusCode} ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Update token dynamically
  void updateToken(String token) {
    _token = token;
    _dio.options.headers['Authorization'] = 'Bearer $_token';
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  // GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  // PUT request
Future<Response> put(String path, {dynamic data}) async {
  return await _dio.put(path, data: data);
}
Future<Response> patch(String path, {dynamic data}) async {
  return await _dio.patch(path, data: data);
}
// DELETE request
Future<Response> delete(String path, {Map<String, dynamic>? queryParams}) async {
  return await _dio.delete(path, queryParameters: queryParams);
}

}
