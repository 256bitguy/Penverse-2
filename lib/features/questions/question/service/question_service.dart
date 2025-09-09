// lib/features/questions/data/questions_service.dart

import '../reduxx/question_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class QuestionsService {
  final ApiClient client;

  QuestionsService(this.client);

  /// Fetch a single question by its ID
  Future<QuestionModel> fetchQuestionById(String questionId) async {
    print("Fetching question with ID: $questionId");

    final response = await client.get(ApiEndpoints.questionById(questionId));
    final body = response.data;

    print("Single Question API Response: $body");

    // Validate structure
    if (body is Map<String, dynamic> && body['data'] is Map<String, dynamic>) {
      final questionData = Map<String, dynamic>.from(body['data']);
      return QuestionModel.fromJson(questionData);
    } else {
      throw Exception("Unexpected response format: $body");
    }
  }

  /// Fetch questions by topic ID
  Future<List<QuestionModel>> fetchQuestionsByTopicId(String topicId) async {
    print("Fetching questions for topic ID: $topicId");

    final response = await client.get(ApiEndpoints.questionsAll(topicId));
    final body = response.data;

    print("Questions by Topic API Response: $body");

    if (body is Map<String, dynamic> && body['data'] is List) {
      final dataList = body['data'] as List<dynamic>;
      return dataList
          .map((q) => QuestionModel.fromJson(Map<String, dynamic>.from(q)))
          .toList();
    } else {
      throw Exception("Unexpected response format: $body");
    }
  }
}
