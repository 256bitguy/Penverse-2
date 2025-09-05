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
    // print("fifth");
    // Ensure response.data is a List
    final data = response.data as List<dynamic>;
    // print("RAW RESPONSE DATA: ${response.data}");
    // Map each JSON item into a VocabItem
    return data.map((json) => VocabItem.fromJson(json)).toList();
  }
}
