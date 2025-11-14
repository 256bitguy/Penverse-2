import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penverse/core/constants/constants.dart';

class StoryScreen extends StatelessWidget {
  final Map<String, dynamic> story;

  const StoryScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final blocks = story['blocks'] as List<dynamic>;

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text(story['title'] ?? 'Story'),
        centerTitle: true,
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        
        itemCount: blocks.length,
        itemBuilder: (context, index) {
          final block = blocks[index];
          final type = block['type'];
          final content = block['content'];

          switch (type) {
            case 'heading':
              return _buildHeading(content);
            case 'paragraph':
              return _buildParagraph(content);
            case 'image':
              return _buildImage(content);
            case 'quote':
              return _buildQuote(content);
            case 'list':
              return _buildList(content);
            case 'question':
              return _buildQuestion(content);
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  /* ------------------- UI BLOCKS ------------------- */

  Widget _buildHeading(Map<String, dynamic> content) {
    final text = content['text'] ?? '';
    final level = content['level'] ?? 2;
    final fontSize = {1: 26.0, 2: 22.0, 3: 18.0}[level] ?? 22.0;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
  }

  Widget _buildParagraph(Map<String, dynamic> content) {
    final children = content['children'] as List<dynamic>;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        children: children.map((child) {
          final text = child['text'] ?? '';
          final bold = child['bold'] ?? false;
          final italic = child['italic'] ?? false;
          final underline = child['underline'] ?? false;
          final color = child['color'];
          final link = child['link'];

          TextStyle style = GoogleFonts.lato(
            fontSize: 16,
            color: color != null ? _parseColor(color) :  Colors.white,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none,
          );

          final span = TextSpan(text: text, style: style);

          return link != null
              ? GestureDetector(
                  onTap: () {
                    // TODO: implement link navigation
                  },
                  child: Text.rich(span),
                )
              : Text.rich(span);
        }).toList(),
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> content) {
    final url = content['url'] ?? '';
    final caption = content['caption'] ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(url),
          ),
          if (caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                caption,
                style: GoogleFonts.lato(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuote(Map<String, dynamic> content) {
    final children = content['children'] as List<dynamic>;
    final author = content['author'] ?? '';

    final text = children.map((e) => e['text']).join(" ");
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: Colors.blueGrey.shade300, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.lato(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          if (author.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                "- $author",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildList(Map<String, dynamic> content) {
    final style = content['style'] ?? 'bulleted';
    final items = content['items'] as List<dynamic>;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (i) {
          final prefix = style == 'numbered' ? '${i + 1}.' : '•';
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '$prefix ${items[i]}',
              style: GoogleFonts.lato(fontSize: 16),
              selectionColor: Colors.white,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuestion(Map<String, dynamic> content) {
    final statement = content['statement'];
    final options = content['options'] as List<dynamic>;
    final correct = content['correctAnswer'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            statement,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.cardBackground
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((opt) {
            final isCorrect = opt['statement'] == correct;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.circle_outlined,
                    color: isCorrect ? Colors.green : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    opt['statement'],
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: isCorrect ? Colors.green.shade700 : Colors.black87,
                      fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /* ------------------- Helper ------------------- */
  Color _parseColor(String hex) {
    try {
      if (hex.startsWith('#')) {
        return Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
      } else {
        return Colors.black;
      }
    } catch (_) {
      return Colors.black;
    }
  }
}
