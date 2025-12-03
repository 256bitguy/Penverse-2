import 'package:penverse/core/api/api_client.dart';
import 'package:penverse/core/api/api_endpoints.dart';
import 'package:penverse/core/models/book_model.dart';

class PurchasedService {
  final ApiClient client;

  PurchasedService(this.client);

  Future<Map<String, dynamic>> purchasedBooks({
    int page = 1,
    int limit = 10,
  }) async {
    

    final response = await client.get(
      ApiEndpoints.purchasedBooks(),
       
    );

    final body = response.data;


    if (body is! Map<String, dynamic>) {
      throw Exception("Unexpected API format");
    }

    final List<dynamic> rawList = body["data"] ?? [];

    // Convert each purchased item into Book + purchasedAt included
    final List<Book> books = rawList.map((item) {
      final bookJson = Map<String, dynamic>.from(item["book"]);
      bookJson["purchasedAt"] = item["purchasedAt"]; // 👈 inject purchased date
      return Book.fromJson(bookJson);
    }).toList();

    return {
      "books": books,
      "totalResults": body["total"] ?? books.length,
      "totalPages": ((body["total"] ?? 0) / limit).ceil(),
      "currentPage": page,
    };
  }
}
