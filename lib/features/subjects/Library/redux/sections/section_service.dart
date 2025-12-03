import 'package:penverse/core/api/api_client.dart';
import 'package:penverse/core/api/api_endpoints.dart';
 
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';
import 'package:penverse/features/subjects/Library/redux/sections/section_model.dart';
 
class SectionService {
  final ApiClient client;

  SectionService(this.client);

  Future<List<Section>> getSections(String libraryId) async {
    final response = await client.get(
      ApiEndpoints.getLibrarySections(libraryId),
    );

    final body = response.data;
     
    

    if (body is! Map<String, dynamic>) {
      throw Exception("Unexpected sections API response format");
    }

    if (body["success"] != true) {
      throw Exception(body["message"] ?? "Failed to load sections");
    }

    final List sectionsJson = body["sections"] ?? [];
    // print("print nahi ho rha bc");
    return sectionsJson.map((json) {
      return Section.fromJson({
        "sectionId":
            json["_id"], // <-- map backend `_id` to your model's sectionId
        "libraryId": libraryId, // <-- backend does not return libraryId
        "sectionName": json["sectionName"],
        "imageUrl": json["imageUrl"],
        "description": json["description"],
        "books": json["books"] ?? [],
      });
    }).toList();
  }

  Future<Section> addSection({
    required String libraryId,
    required String name,
    String? picture,
    String? description,
  }) async {
    final response = await client.post(
      ApiEndpoints.createSection(),
      data: {
        "libraryId": libraryId,
        "sectionName": name,
        "imageUrl": picture,
        "description": description,
      },
    );

    final body = response.data;

    if (body is! Map<String, dynamic> || body["section"] == null) {
      throw Exception("Unexpected add section response format");
    }

    // print("Service returned: ${body["section"]}");

    return Section.fromJson(body["section"]);
  }

  // Future<Section> editSection(String sectionId, Map<String, dynamic> data) async {
  //   print("Editing section $sectionId with data: $data");

  //   final response = await client.patch(
  //     ApiEndpoints.editSection(sectionId),
  //     data: data,
  //   );

  //   final body = response.data;
  //   print("Edit Section Response: $body");

  //   if (body is! Map<String, dynamic> || body["section"] == null) {
  //     throw Exception("Unexpected edit section response format");
  //   }

  //   return Section.fromJson(body["section"]);
  // }

Future<List<SectionBook>> getBooksInSection(String sectionId) async {
  // print("Fetching books for sectionId: $sectionId");

  final response = await client.get(
    ApiEndpoints.getSectionBooks(sectionId),
  );

  final body = response.data;
  // print("Books API Response: $body");

  if (body is! Map<String, dynamic> || body["books"] == null) {
    throw Exception("Unexpected books API response format");
  }

  final List<dynamic> booksJson = body["books"];

  return booksJson
      .map((json) => SectionBook.fromJson(json))
      .toList();
}


  Future<Map<String, dynamic>> addBookToSection(
    String sectionId,
    String bookId,
  ) async {
    // print("Adding book $bookId to section $sectionId");

    final response = await client.post(
      ApiEndpoints.addBookToSection(sectionId),
      data: {
        "bookId": bookId,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add book to section: ${response.data}");
    }

    final body = response.data;
    // print("Add Book Response: $body");

    if (body == null || body["section"] == null) {
      throw Exception("Invalid response format from backend");
    }

    return {
      "success": body["success"],
      "message": body["message"],
      "section": body["section"], // contains updated books list
    };
  }

  // Future<void> removeBookFromSection(String sectionId, String bookId) async {
  //   print("Removing book $bookId from section $sectionId");

  //   final response = await client.delete(
  //     ApiEndpoints.deleteBookFromSection(sectionId, bookId),
  //   );

  //   final body = response.data;
  //   print("Remove Book Response: $body");

  //   if (response.statusCode != 200) {
  //     throw Exception("Failed to remove book from section: $body");
  //   }
  // }

  // Future<void> reorderBooks(String sectionId, String lastOpenedBookId) async {
  //   print("Reordering books in section $sectionId, lastOpenedBookId: $lastOpenedBookId");

  //   final response = await client.post(
  //     ApiEndpoints.reorderBooks(sectionId),
  //     data: {"lastOpenedBookId": lastOpenedBookId},
  //   );

  //   final body = response.data;
  //   print("Reorder Books Response: $body");

  //   if (response.statusCode != 200) {
  //     throw Exception("Failed to reorder books in section: $body");
  //   }
  // }
}
