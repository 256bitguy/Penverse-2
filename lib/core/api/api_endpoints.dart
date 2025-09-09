class ApiEndpoints {
  // Base URL
  // static const String baseUrl = "https://penverse-app-backend-2.onrender.com/api/v1";
  static const String baseUrl = "http://localhost:5000/api/v1";

  // ===== SUBJECTS, BOOKS, CHAPTERS, TOPICS =====
  static const String subjects = "$baseUrl/subjects";
  static String subject() => subjects;

  static const String books = "$baseUrl/books/subject";
  static String book(String id) => "$books/$id";

  static const String chapters = "$baseUrl/chapters/book";
  static String chapter(String id) => "$chapters/$id";

  static const String topics = "$baseUrl/topics/chapter";
  static String topic(String id) => "$topics/$id";

  static const String notes = "$baseUrl/notes/topic";
  static String note(String id) => "$notes/$id";

  // ===== QUESTIONS =====
  static const String questionsall = "$baseUrl/questions/topic";
  static String questionsAll(String id) => "$questionsall/$id";

  static const String question = "$baseUrl/questions/topic";
  static String questionById(String id) => "$question/$id";

  // ===== AWARENESS =====
  static const String awareness = "$baseUrl/awareness";
  static String awarenessById(String id) => "$awareness/$id";
  static String awarenessSearchByTitle(String title) => "$awareness/search/title?title=$title";

  // ===== DAILY AWARENESS =====
  static const String dailybankingawareness = "$baseUrl/dailybankingawareness";
  static String dailyAwarenessByDate(String date) => "$dailybankingawareness/$date";

  static const String dailybankingawarenesstopic = "$baseUrl/dailybankingawareness/topic";
  static String awarenessByTopic(String id) => "$dailybankingawarenesstopic/$id";

  // ===== DAILY EDITORIAL =====
  static const String dailyEditorial = "$baseUrl/dailyeditorial";
  static String dailyEditorialByDate(String date) => "$dailyEditorial/$date";

  // ===== DAILY IDIOMS =====
  static const String dailyIdioms = "$baseUrl/dailyidioms";
  static String dailyIdiomsByDate(String date) => "$dailyIdioms/$date";

  static const String topicIdioms = "$baseUrl/dailyidioms/topic";
  static String idiomsByTopic(String topicid) => "$topicIdioms/$topicid";

  // ===== DAILY PHRASAL VERBS =====
  static const String dailyPhrasalVerbs = "$baseUrl/dailyphrasal";
  static String dailyPhrasalVerbsByDate(String date) => "$dailyPhrasalVerbs/$date";

  static const String topicPhrasalVerbs = "$baseUrl/phrasalverb/topic";
  static String phrasalVerbsByTopic(String topicid) => "$topicPhrasalVerbs/$topicid";

  // ===== DAILY VOCAB =====
  static const String dailyVocab = "$baseUrl/dailyvocab";
  static String dailyVocabByDate(String date) => "$dailyVocab/$date";

  static const String topicVocab = "$baseUrl/vocabulary/topic";
  static String vocabByTopic(String topicid) => "$topicVocab/$topicid";
}
