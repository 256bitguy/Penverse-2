import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/Payment_page.dart';
class BookPreviewPage extends StatelessWidget {
  const BookPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    const book = {
      "book_id": 1, // added sample book_id
      "title": "Atomic Habits",
      "author": "James Clear",
      "images": [
        "https://m.media-amazon.com/images/I/81-QB7nDh4L._SY466_.jpg",
        "https://m.media-amazon.com/images/I/71aFt4+OTOL._SY466_.jpg",
        "https://m.media-amazon.com/images/I/81bsw6fnUiL._SY466_.jpg",
      ],
      "rating": 4.8,
      "reviews": "1,20,000+ ratings",
      "price": "₹449",
      "overview":
          "Tiny Changes, Remarkable Results. Atomic Habits offers a proven framework for improving yourself every day. Learn how to make time for new habits, overcome a lack of motivation, and design your environment to make success easier.",
      "aboutAuthor":
          "James Clear is a writer and speaker focused on habits, decision-making, and continuous improvement. He is the author of the #1 New York Times bestseller *Atomic Habits*, which has sold more than 10 million copies worldwide.",
    };

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 1,
        title: Text(
          "${book["title"]}",
          style: const TextStyle(
              color: Color.fromARGB(255, 218, 217, 217),
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 240, 235, 235)),
      ),

      // ===================== BODY =====================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "${book["title"]}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Image Carousel
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: (book["images"] as List).length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  final imageUrl = (book["images"] as List)[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
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
                        "${book["rating"]} (${book["reviews"]})",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: ${book["price"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Readers and Author
            Container(
              margin: const EdgeInsets.all(12.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Readers: 1.2k'),
                  Text('Author: Vivek Kumar'),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // Book Overview
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Book Overview",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${book["overview"]}",
                    maxLines: 2,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // About Author
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About the Author",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${book["aboutAuthor"]}",
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1),

            // Ratings Section
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ratings & Reviews",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "4.8",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Icon(Icons.star_half, color: Colors.orange, size: 18),
                        ],
                      ),
                      SizedBox(width: 8),
                      Text("based on 1,20,000+ reviews"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80), // extra space above buttons
          ],
        ),
      ),

      // ===================== BOTTOM BUTTONS =====================
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
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()),
                  );
                },
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
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
                  // TODO: Navigate to Sample page with book_id
                  // Example: Navigator.pushNamed(context, '/sample', arguments: book["book_id"]);
                },
                child: Text(
                  "Sample",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
