import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/api_client.dart';
import '../banking_awareness_state.dart'; // Your EditorialItem model

class BankingAwarenessService {
  final ApiClient client;

  BankingAwarenessService(this.client);

  Future<List<BankingAwarenessItem>> getDailyBankingAwareness(DateTime date) async {
    // 1. Get current date
    

    // 2. Format date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

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

 
}
