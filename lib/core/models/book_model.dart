class Book {
  final String id;
  final String createdBy;
  final String title;
  final bool isPublished;
  final String description;
  final String coverImage;
  final String author;
  final int publishedYear;
  final int totalChapters;
  final int totalReaders;
  final double rating;
  final String type;
  final int price;
  final int discountPrice;
  final String language;
  final bool previewAvailable;
  final List<String> tags;
  final int popularityScore;
  final String? institutionId;
  final List<String> courseIds;
  final List<String> genreIds;
  final String? purchasedAt;

  Book({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.isPublished,
    required this.description,
    required this.coverImage,
    required this.author,
    required this.publishedYear,
    required this.totalChapters,
    required this.totalReaders,
    required this.rating,
    required this.type,
    required this.price,
    required this.discountPrice,
    required this.language,
    required this.previewAvailable,
    required this.tags,
    required this.popularityScore,
    required this.institutionId,
    required this.courseIds,
    required this.genreIds,
     this.purchasedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'] ?? "",
      createdBy: json['createdBy'] ?? "",
      title: json['title'] ?? "",
      isPublished: json['isPublished'] ?? false,
      description: json['description'] ?? "",
      coverImage: json['coverImage'] ?? "",
      author: json['author'] ?? "",
      publishedYear: json['publishedYear'] ?? 0,
      totalChapters: json['totalChapters'] ?? 0,
      totalReaders: json['totalReaders'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      type: json['type'] ?? "general",
      price: json['price'] ?? 0,
      discountPrice: json['discountPrice'] ?? 0,
      language: json['language'] ?? "english",
      previewAvailable: json['previewAvailable'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      popularityScore: json['popularityScore'] ?? 0,
      institutionId: json['institutionId'],
      courseIds: List<String>.from(json['courseIds'] ?? []),
      genreIds: List<String>.from(json['genreIds'] ?? []),
      purchasedAt: json['purchasedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "createdBy": createdBy,
      "title": title,
      "isPublished": isPublished,
      "description": description,
      "coverImage": coverImage,
      "author": author,
      "publishedYear": publishedYear,
      "totalChapters": totalChapters,
      "totalReaders": totalReaders,
      "rating": rating,
      "type": type,
      "price": price,
      "discountPrice": discountPrice,
      "language": language,
      "previewAvailable": previewAvailable,
      "tags": tags,
      "popularityScore": popularityScore,
      "institutionId": institutionId,
      "courseIds": courseIds,
      "genreIds": genreIds,
      "purchasedAt": purchasedAt,
    };
  }
}
