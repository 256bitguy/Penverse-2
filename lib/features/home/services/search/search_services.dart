import 'package:penverse/core/models/book_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
 

class SearchService {
  final ApiClient client;

  SearchService(this.client);

  /// Search for books by query with pagination.
  Future<Map<String, dynamic>> searchBooks({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
   

    final response = await client.get(
      ApiEndpoints.searchBooks(
        query,
        page,
        limit,
      ),
    );

    final body = response.data;
   

    if (body is Map<String, dynamic>) {
      final booksList = (body['books'] as List<dynamic>? ?? [])
          .map((json) => Book.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      return {
        "books": booksList,
        "totalResults": body['totalResults'] ?? 0,
        "totalPages": body['totalPages'] ?? 1,
        "currentPage": body['currentPage'] ?? 1,
      };
    }

    throw Exception("Unexpected response format: $body");
  }

  Future<Map<String, dynamic>> searchBooksByGenre({
    required String genreId,
    int page = 1,
    int limit = 10,
  }) async {
   

    final response = await client.get(
      ApiEndpoints.searchBooksByGenre(
        genreId,
        page,
        limit,
      ),
    );

    final body = response.data;
    

    if (body is Map<String, dynamic>) {
      final booksList = (body['books'] as List<dynamic>? ?? [])
          .map((json) => Book.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      return {
        "books": booksList,
        "totalResults": body['totalResults'] ?? 0,
        "totalPages": body['totalPages'] ?? 1,
        "currentPage": body['currentPage'] ?? 1,
      };
    }

    throw Exception("Unexpected response format: $body");
  }

  Future<Map<String, dynamic>> searchBooksByCourse({
    required String courseId,
    int page = 1,
    int limit = 10,
  }) async {
   

    final response = await client.get(
      ApiEndpoints.searchBooksByCourse(
        courseId,
        page,
        limit,
      ),
    );

    final body = response.data;
   

    if (body is Map<String, dynamic>) {
      final booksList = (body['books'] as List<dynamic>? ?? [])
          .map((json) => Book.fromJson(Map<String, dynamic>.from(json)))
          .toList();

      return {
        "books": booksList,
        "totalResults": body['totalResults'] ?? 0,
        "totalPages": body['totalPages'] ?? 1,
      };
    }

    throw Exception("Unexpected response format: $body");
  }
}
