import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/api_client.dart';
import '../banking_awareness_state.dart'; // Your EditorialItem model

class BankingAwarenessService {
  final ApiClient client;

  BankingAwarenessService(this.client);

  Future<List<BankingAwarenessItem>> getDailyBankingAwareness() async {
    // 1. Get current date
    final now = DateTime.now();

    // 2. Format date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // 3. API Call
    final response =
        await client.get(ApiEndpoints.dailyAwarenessByDate(formattedDate));

     

   
     
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid editorial response: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;

     
    return list.map((json) => BankingAwarenessItem.fromJson(json)).toList();
  }


   Future<List<BankingAwarenessItem>> AwarenessByTopic(String topicId) async {
    if (topicId.isEmpty) {
      throw Exception("topicId cannot be empty");
    }

    final response = await client.get(ApiEndpoints.awarenessByTopic(topicId));
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid response for topicId $topicId: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;
    return list.map((json) => BankingAwarenessItem.fromJson(json)).toList();
  }
}
