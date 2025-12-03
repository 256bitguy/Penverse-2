import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/api_client.dart';
import '../editorial_state.dart'; // Your EditorialItem model

class EditorialService {
  final ApiClient client;

  EditorialService(this.client);

  Future<List<EditorialItem>> getDailyEditorials() async {
    // 1. Get current date
    final now = DateTime.now();

    // 2. Format date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // 3. API Call
    final response =
        await client.get(ApiEndpoints.dailyEditorialByDate(formattedDate));

    // 4. Print raw response for debugging

    // 5. Extract data
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid editorial response: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;

    // 6. Map to EditorialItem list
    return list.map((json) => EditorialItem.fromJson(json)).toList();
  }

  Future<List<EditorialItem>> getEditorialByDate(DateTime date) async {
    // Format the passed date as YYYY-MM-DD
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
   

    // API Call
    final response = await client.get(
      ApiEndpoints.dailyEditorialByDate(formattedDate),
    );

    // Extract data
    final body = response.data;

    if (body == null || body['data'] == null) {
      throw Exception("Invalid editorial response: ${response.data}");
    }

    final list = body['data'] as List<dynamic>;

    // Map to EditorialItem list
    return list.map((json) => EditorialItem.fromJson(json)).toList();
  }
}
