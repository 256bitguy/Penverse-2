// lib/features/books/data/book_service.dart

import 'package:penverse/core/models/book_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class BookService {
  final ApiClient client;

  BookService(this.client);

  Future<List<Book>> fetchBooksBySubject(String subjectId) async {
   

    final response = await client.get(ApiEndpoints.book(subjectId));
    final body = response.data;


    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;

      return list
          .map((json) => Book.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
}
