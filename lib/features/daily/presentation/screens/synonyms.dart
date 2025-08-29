import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class SynonymPage extends StatelessWidget {
  const SynonymPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Map<String, String>> synonymList = [
      {
        "english": "Happy",
        "hindi": "खुश",
        "usage_en": "She is very happy today.",
        "usage_hi": "वह आज बहुत खुश है।"
      },
      {
        "english": "Strong",
        "hindi": "मजबूत",
        "usage_en": "He is a strong person.",
        "usage_hi": "वह एक मजबूत व्यक्ति है।"
      },
      {
        "english": "Friend",
        "hindi": "दोस्त",
        "usage_en": "My friend helps me every day.",
        "usage_hi": "मेरा दोस्त हर दिन मेरी मदद करता है।"
      },
      {
        "english": "Beautiful",
        "hindi": "सुंदर",
        "usage_en": "This place is very beautiful.",
        "usage_hi": "यह जगह बहुत सुंदर है।"
      },
      {
        "english": "Fast",
        "hindi": "तेज़",
        "usage_en": "The car is very fast.",
        "usage_hi": "गाड़ी बहुत तेज़ है।"
      },
    ];

    return Scaffold(
   
      appBar: AppBar(
        title: const Text("Synonyms"),
        backgroundColor: AppColors.scaffoldBackground,
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(), // smooth scroll
        padding: const EdgeInsets.all(16),
        itemCount: synonymList.length,
        itemBuilder: (context, index) {
          final item = synonymList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // English and Hindi words in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["english"]!,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      item["hindi"]!,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Usage sentence (English)
                Text(
                  "  ${item["usage_en"]}",
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 4),

                // Usage sentence (Hindi)
                Text(
                  "  ${item["usage_hi"]}",
                  style:
                      const TextStyle(fontSize: 16, color: Colors.greenAccent),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
