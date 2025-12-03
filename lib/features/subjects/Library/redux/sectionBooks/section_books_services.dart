import 'package:penverse/core/api/api_client.dart';
import 'package:penverse/core/api/api_endpoints.dart';
import 'package:penverse/features/subjects/Library/redux/sectionBooks/section_book_model.dart';

class SectionBooksService {
  final ApiClient client;

  SectionBooksService(this.client);

  /// Fetch books in a specific section
  Future<Map<String, dynamic>> getBooksInSection({
    required String sectionId,
  }) async {
    final response = await client.get(
      ApiEndpoints.getSectionBooks(sectionId),
    );

    final body = response.data;
    // print(body);
    if (body is! Map<String, dynamic> || body["books"] == null) {
      throw Exception("Unexpected API response format");
    }

    final List<dynamic> rawBooks = body["books"];

    // Convert JSON to SectionBook
    final List<SectionBook> books =
        rawBooks.map((json) => SectionBook.fromJson(json)).toList();

    return {
      "books": books,
    };
  }
}
