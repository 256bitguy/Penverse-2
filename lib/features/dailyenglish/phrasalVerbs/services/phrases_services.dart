import 'package:intl/intl.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/api_client.dart';
import '../../phrasalVerbs/phrasal_verb_state.dart'; // Your PhrasalVerbItem model

class PhrasalVerbService {
  final ApiClient client;

  PhrasalVerbService(this.client);

Future<List<PhrasalVerbItem>> getDailyPhrasalVerbs() async {
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd').format(now);

  final response = await client.get(ApiEndpoints.dailyPhrasalVerbsByDate(formattedDate));

  final body = response.data;

  print("📢 Raw API Response: $body");
  print("Response runtimeType: ${body.runtimeType}");

  // ✅ Ensure body is a Map with a 'data' key
  if (body is Map<String, dynamic> && body['data'] is List) {
    final list = body['data'] as List<dynamic>;

    return list
        .map((json) => PhrasalVerbItem.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  throw Exception("Unexpected response format: $body");
}

}
