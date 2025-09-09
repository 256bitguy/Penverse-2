import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/api_client.dart';
import '../idioms_state.dart'; // Your IdiomItem model

class IdiomService {
  final ApiClient client;

  IdiomService(this.client);

  Future<List<IdiomItem>> getDailyIdioms() async {
    // 1. Get current date
    final now = DateTime.now();

    // 2. Format date
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // 3. API Call
    final response = await client.get(ApiEndpoints.dailyIdiomsByDate(formattedDate));

    // 4. Debug log
 

    // 5. Extract data safely
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid idiom response: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;

    // 6. Convert JSON to IdiomItem
    return list.map((json) => IdiomItem.fromJson(json)).toList();
  }
  Future<List<IdiomItem>> fetchIdiomsByTopic(String topicId) async {
  if (topicId.isEmpty) {
    throw Exception("topicId cannot be empty");
  }

  // API Call using topicId
  final response = await client.get(ApiEndpoints.idiomsByTopic(topicId));

  // Extract data safely
  final body = response.data;
  if (body == null || body['data'] == null) {
    throw Exception("Invalid response for topicId $topicId: ${response.data}");
  }

  final list = body['data'] as List<dynamic>;

  // Convert JSON to IdiomItem
  return list.map((json) => IdiomItem.fromJson(json)).toList();
}
}
