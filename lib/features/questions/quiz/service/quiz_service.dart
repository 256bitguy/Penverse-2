// lib/features/quiz/data/quiz_service.dart

import '../redux/quiz_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class QuizService {
  final ApiClient client;

  QuizService(this.client);

  /// Fetch a single quiz by its ID (QuestionSet _id)
Future<QuizModel> fetchQuizById(String quizId) async {
  print("Fetching quiz with ID: $quizId");

  final response = await client.get(ApiEndpoints.quizById(quizId));
  final body = response.data;

  print("Single Quiz API Response: $body");

  if (body is Map<String, dynamic> && body['data'] is Map<String, dynamic>) {
    return QuizModel.fromJson(Map<String, dynamic>.from(body['data']));
  } else {
    throw Exception("Unexpected response format: $body");
  }
}


  /// Fetch all quizzes by topicId
  Future<List<QuizListItem>> fetchQuizzesByTopicId(String topicId) async {
    print("Fetching quizzes for topic ID: $topicId");

    final response = await client.get(ApiEndpoints.quizzesAll(topicId));
    final body = response.data;

    print("Quizzes by Topic API Response: $body");

    if (body is Map<String, dynamic> && body['data'] is List) {
      final dataList = body['data'] as List<dynamic>;
      return dataList
          .map((q) => QuizListItem.fromJson(Map<String, dynamic>.from(q)))
          .toList();
    } else {
      throw Exception("Unexpected response format: $body");
    }
  }
}
