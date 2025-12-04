// lib/features/chapter/data/chapter_service.dart

import 'package:penverse/features/subjects/chapter/redux/chapter_model.dart';

import '../redux/chapter_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class ChapterService {
  final ApiClient client;

  ChapterService(this.client);

  /// Fetch chapters for a specific book
  Future<List<Chapter>> fetchChaptersByBook(String bookId) async {


    final response = await client.get(ApiEndpoints.chapter(bookId));
    final body = response.data;



    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;

      return list
          .map((json) => Chapter.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
}
