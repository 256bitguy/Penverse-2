import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../vocab_state.dart';
import '../../../../core/api/api_client.dart';

class VocabService {
  final ApiClient client;

  VocabService(this.client);

  Future<List<VocabItem>> getDailyVocab() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final response =
        await client.get(ApiEndpoints.dailyVocabByDate(formattedDate));

    final body = response.data;

    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;
      return list
          .map((json) => VocabItem.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
  Future<List<VocabItem>> fetchVocabByTopic(String topicId) async {
  if (topicId.isEmpty) {
    throw Exception("topicId cannot be empty");
  }

  final response = await client.get(ApiEndpoints.vocabByTopic(topicId));

  final body = response.data;

  if (body is Map<String, dynamic> && body['data'] is List) {
    final list = body['data'] as List<dynamic>;
    return list
        .map((json) => VocabItem.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  throw Exception("Unexpected response format for topicId $topicId: $body");
}
  Future<List<VocabItem>> getVocabByDate(DateTime date) async {
    // Format the passed date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
  
    // API Call
    final response = await client.get(
      ApiEndpoints.dailyVocabByDate(formattedDate),
    );

    // Extract data
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid editorial response: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;

    // Map to EditorialItem list
    return list.map((json) => VocabItem.fromJson(json)).toList();
  }

}
