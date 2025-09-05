class ApiEndpoints {
  static const String baseUrl = "http://localhost:8000/api/v1";

  // ===== AWARENESS =====
  static const String awareness = "$baseUrl/awareness";

  static String awarenessById(String id) => "$awareness/$id";
  static String awarenessSearchByTitle(String title) => "$awareness/search/title?title=$title";

  // ===== DAILY AWARENESS =====
  static const String dailyAwareness = "$baseUrl/dailyawareness";
  static String dailyAwarenessByDate(String date) => "$dailyAwareness/$date";

  // ===== DAILY EDITORIAL =====
  static const String dailyEditorial = "$baseUrl/dailyeditorial";
  static String dailyEditorialByDate(String date) => "$dailyEditorial/$date";

  // ===== DAILY IDIOMS =====
  static const String dailyIdioms = "$baseUrl/dailyidioms";
  static String dailyIdiomsByDate(String date) => "$dailyIdioms/$date";

  // ===== DAILY PHRASAL VERBS =====
  static const String dailyPhrasalVerbs = "$baseUrl/dailyphrasal";
  static String dailyPhrasalVerbsByDate(String date) => "$dailyPhrasalVerbs/$date";

  // ===== DAILY VOCAB =====
  static const String dailyVocab = "$baseUrl/dailyvocabs";
  static String dailyVocabByDate(String date) => "$dailyVocab/$date";

  // // ===== EDITORIAL =====
  // static const String editorial = "$baseUrl/editorial";

  // static const String editorialSearch = "$editorial/search";

  // // ===== IDIOMS =====
  // static const String idioms = "$baseUrl/idioms";
  // static String idiomsById(String id) => "$idioms/$id";

  // // ===== PHRASAL VERBS =====
  // static const String phrasalVerbs = "$baseUrl/phrasal-verbs";
  // static String phrasalVerbsById(String id) => "$phrasalVerbs/$id";
  // static String phrasalVerbsByTopicId(String topicId) => "$phrasalVerbs/topic/$topicId";

  // // ===== VOCABULARY =====
  // static const String vocabulary = "$baseUrl/vocabulary";
  // static String vocabularyById(String id) => "$vocabulary/$id";
  // static String vocabularyByTopic(String topicId) => "$vocabulary/$topicId";
  // static const String vocabularyPublish = "$vocabulary/publish";
  // static const String vocabularyByDate = "$vocabulary/by-date";
}
