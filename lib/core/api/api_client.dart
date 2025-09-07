import 'package:dio/dio.dart';
 
class ApiClient {
  late Dio _dio;

  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  /// Initialize Dio with base URL, interceptors, etc.
  void init({required String baseUrl, String? authToken}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        headers: {
          'Content-Type': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
      ),
    );

    // Interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('➡️ Request: r ${options.method} ${options.path}');
          // print('Headers:r ${options.headers}');
          // print('Data: r${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print('✅ Response:r ${response.statusCode} in client file ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          print('❌ Error:r ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    
    return await _dio.get(path, queryParameters: queryParams);
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  // PUT request
  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }
}
