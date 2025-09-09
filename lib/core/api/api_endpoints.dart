class ApiEndpoints {
  // static const String baseUrl = "https://penverse-app-backend-2.onrender.com/api/v1";
  static const String baseUrl = "http://localhost:8000/api/v1";

  // ===== AWARENESS =====
  static const String awareness = "$baseUrl/awareness";

  static String awarenessById(String id) => "$awareness/$id";
  static String awarenessSearchByTitle(String title) => "$awareness/search/title?title=$title";

  // ===== DAILY AWARENESS =====
  static const String dailybankingawareness = "$baseUrl/dailybankingawareness";
  static String dailyAwarenessByDate(String date) => "$dailybankingawareness/$date";

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
  static const String dailyVocab = "$baseUrl/dailyvocab";
  static String dailyVocabByDate(String date) => "$dailyVocab/$date";
 
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

   static const String questionsall = "$baseUrl/questions/topic";
  static String questionsAll(String id) => "$questionsall/$id";
 
   static const String question = "$baseUrl/questions/topic";
  static String questionById(String id) => "$question/$id";
}
