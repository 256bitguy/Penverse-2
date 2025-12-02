import 'package:flutter/material.dart';
import 'package:penverse/features/home/services/home/payment_viewmodel.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/Payment_page.dart';
import '../../../../core/models/book_model.dart';

class BookPreviewPage extends StatelessWidget {
  final Book book;

  const BookPreviewPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 1,
        title: Text(
          book.title ?? '',
          style: const TextStyle(
              color: Color.fromARGB(255, 218, 217, 217),
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 240, 235, 235)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                book.title ?? '',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            
            // Book Cover Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.coverImage ?? '',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Book Details Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange[700], size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${book.rating} (${book.totalReaders} readers)',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: ₹${book.discountPrice ?? book.price}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // Book Description
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Book Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    book.description ?? '',
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // Book Metadata
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Author: ${book.author ?? ''}'),
                  Text('Year: ${book.publishedYear ?? ''}'),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.scaffoldBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>   PaymentPage(bookId: book.id )),
                  );
                },
                child: const Text('Buy Now', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Navigate to sample page using book._id
                  // Navigator.pushNamed(context, '/sample', arguments: book.id);
                },
                child: Text('Sample', style: TextStyle(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
