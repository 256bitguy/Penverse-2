import 'package:penverse/core/api/api_client.dart';
import 'package:penverse/core/api/api_endpoints.dart';

class LibraryService {
  final ApiClient client;

  LibraryService(this.client);

  /// --------------------------
  /// GET USER LIBRARY
  /// --------------------------
  Future<Map<String, dynamic>> getLibrary() async {
  

    final response = await client.get(ApiEndpoints.getLibrary());
    final body = response.data;


    if (body is! Map<String, dynamic> || body["library"] == null) {
      throw Exception("Unexpected library API response format");
    }

    final library = body["library"];

    return {
      "libraryId": library["_id"],
      "libraryName": library["libraryName"],
      "userId": library["userId"],
      "createdAt": library["createdAt"],
      "updatedAt": library["updatedAt"],
    };
  }

   
  Future<Map<String, dynamic>> editLibrary(String newName, String libraryId) async {
   

    final response = await client.patch(
      ApiEndpoints.editLibrary(libraryId),
      data: {"libraryName": newName},
    );

    final body = response.data;
   

    if (body is! Map<String, dynamic> || body["library"] == null) {
      throw Exception("Unexpected edit library response format");
    }

    final library = body["library"];

    return {
      "libraryId": library["_id"],
      "libraryName": library["libraryName"],
      "updatedAt": library["updatedAt"],
    };
  }
}
