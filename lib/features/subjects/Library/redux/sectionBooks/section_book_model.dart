class SectionBook {
  final String id;
  final String title;
  final String coverImage;
  final String author;
  final int totalChapters;

  // ---- Future Feature: Reading Progress ----
  final int completedChapters;     // how many chapters user has finished
  final double progressPercentage; // 0.0 - 100.0

  SectionBook({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.author,
    required this.totalChapters,
    this.completedChapters = 0,
    this.progressPercentage = 0.0,
  });

  // ---------- FROM JSON ----------
  factory SectionBook.fromJson(Map<String, dynamic> json) {
    final int totalChapters = json["totalChapters"] ?? 0;
    final int completed = json["completedChapters"] ?? 0;

    double percent = 0.0;
    if (totalChapters > 0) {
      percent = (completed / totalChapters) * 100;
    }

    return SectionBook(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      coverImage: json["coverImage"] ?? "",
      author: json["author"] ?? "",
      totalChapters: totalChapters,
      completedChapters: completed,
      progressPercentage:
          json["progressPercentage"]?.toDouble() ?? percent,
    );
  }

  // ---------- TO JSON ----------
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "coverImage": coverImage,
      "author": author,
      "totalChapters": totalChapters,
      "completedChapters": completedChapters,
      "progressPercentage": progressPercentage,
    };
  }
}
