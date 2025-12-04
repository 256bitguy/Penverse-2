// lib/features/books/data/book_service.dart

import 'package:penverse/core/models/book_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class BookService {
  final ApiClient client;

  BookService(this.client);

 Future<List<Book>> fetchBooksBySubject(String subjectId) async {
  try {
    final response = await client.get(ApiEndpoints.book(subjectId));
    final body = response.data;

    // Check that body is a Map and contains a 'data' list
    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;

      // Map each JSON object to a Book
      return list
          .map((json) => Book.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  } catch (e) {
    throw Exception("Failed to fetch books: $e");
  }
}

}
