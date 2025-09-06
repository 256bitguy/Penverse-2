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
    print("📢 Raw API Response: $body");

    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;
      return list
          .map((json) => VocabItem.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
}
