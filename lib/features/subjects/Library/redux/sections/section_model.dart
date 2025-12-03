class Section {
  final String id;
  final String name;
  final String? picture;
  final String? description;
  final List<dynamic> books;

  Section({
    required this.id,
    required this.name,
    this.picture,
    this.description,
    required this.books,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id:   json["sectionId"],
      name: json["sectionName"] ?? "",
      picture: json["imageUrl"],
      description: json["description"],
      books: json["books"] ?? [],
    );
  }
}
