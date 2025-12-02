import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class PaymentService {
  final ApiClient client;

  PaymentService(this.client);

  Future<Map<String, dynamic>> processPayment({
    required String bookId,
  }) async {
    final response = await client.post(
      ApiEndpoints.purchaseBook(
        bookId,
      ),
    );

    final body = response.data;

    if (body) {
      return {
        "isPaid": body['isPaid'] ?? false,
      };
    }

    throw Exception("Unexpected response format: $body");
  }
}
