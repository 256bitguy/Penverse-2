// lib/features/subjects/data/subject_service.dart
 

import '../redux/subject_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class SubjectService {
  final ApiClient client;

  SubjectService(this.client);

  Future<List<Subject>> fetchSubjects() async {
    print("fourth");
    final response = await client.get(ApiEndpoints.subject());
    
     
 final body = response.data;
  print("fourth $body");
    if (body is Map<String, dynamic> && body['data'] is List) {
      final list = body['data'] as List<dynamic>;
      return list
          .map((json) => Subject.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    throw Exception("Unexpected response format: $body");
  }
}
 


 