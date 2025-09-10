import 'package:meta/meta.dart';

@immutable
class QuizState {
  final bool isLoading;
  final List<QuizListItem> quizList;
  final QuizModel? selectedQuiz;
  final String error;

  const QuizState({
    required this.isLoading,
    required this.quizList,
    required this.selectedQuiz,
    required this.error,
  });

  factory QuizState.initial() {
    return const QuizState(
      isLoading: false,
      quizList: [],
      selectedQuiz: null,
      error: '',
    );
  }

  QuizState copyWith({
    bool? isLoading,
    List<QuizListItem>? quizList,
    QuizModel? selectedQuiz,
    String? error,
  }) {
    return QuizState(
      isLoading: isLoading ?? this.isLoading,
      quizList: quizList ?? this.quizList,
      selectedQuiz: selectedQuiz ?? this.selectedQuiz,
      error: error ?? this.error,
    );
  }

  factory QuizState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return QuizState.initial();
    return QuizState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'] ?? '',
      quizList: (json['quizList'] as List? ?? [])
          .map((q) => QuizListItem.fromJson(Map<String, dynamic>.from(q)))
          .toList(),
      selectedQuiz: json['selectedQuiz'] != null
          ? QuizModel.fromJson(Map<String, dynamic>.from(json['selectedQuiz']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'quizList': quizList.map((q) => q.toJson()).toList(),
      'selectedQuiz': selectedQuiz?.toJson(),
    };
  }
}

/// ----------- MODELS -----------

/// Lightweight model for quiz list screen
class QuizListItem {
  final String id;
  final String title;

  QuizListItem({
    required this.id,
    required this.title,
  });

  factory QuizListItem.fromJson(Map<String, dynamic> json) {
    return QuizListItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

/// Full Quiz with questions
class QuizModel {
  final String id; // corresponds to QuestionSet _id
  final String topicId;
  final String? title;
  final String description;
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.topicId,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['_id'] ?? '',
      topicId: json['topicId'] ?? '',
      title: json['title'],
      description: json['description'] ?? '',
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((q) => QuestionModel.fromJson(Map<String, dynamic>.from(q)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'topicId': topicId,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

class QuestionModel {
  final String id;
  final String questionText;
  final String? imageUrl;
  final List<OptionModel> options;
  final String correctAnswer;

  QuestionModel({
    required this.id,
    required this.questionText,
    this.imageUrl,
    required this.options,
    required this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'] ?? '',
      questionText: json['questionText'] ?? '',
      imageUrl: json['imageUrl'],
      options: (json['options'] as List<dynamic>? ?? [])
          .map((o) => OptionModel.fromJson(Map<String, dynamic>.from(o)))
          .toList(),
      correctAnswer: json['correctAnswer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'questionText': questionText,
      'imageUrl': imageUrl,
      'options': options.map((o) => o.toJson()).toList(),
      'correctAnswer': correctAnswer,
    };
  }
}

class OptionModel {
  final String text;

  OptionModel({required this.text});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
