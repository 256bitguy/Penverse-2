// lib/features/subjects/topic/data/topic_service.dart

import '../redux/topic_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class TopicService {
  final ApiClient client;

  TopicService(this.client);

  /// Fetch topics by chapterId
  Future<List<Topic>> fetchTopicsByChapter(String chapterId) async {


    final response = await client.get(ApiEndpoints.topic(chapterId));
    final body = response.data;



    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;

      return list
          .map((json) => Topic.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
}
