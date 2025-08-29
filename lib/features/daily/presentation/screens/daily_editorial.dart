import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
class ParagraphScreen extends StatefulWidget {
  const ParagraphScreen({super.key});

  @override
  State<ParagraphScreen> createState() => _ParagraphScreenState();
}

class _ParagraphScreenState extends State<ParagraphScreen> {
  late Timer _timer;
  int _seconds = 0;

  final String paragraph = """
In a rapidly changing world, knowledge and information have become the most valuable resources for human progress. The ability to think critically, analyze data, and make informed decisions separates successful societies from those that struggle to adapt. Education has therefore become more than just a tool for personal growth; it is a foundation for innovation, equality, and the well-being of communities. Every generation inherits not only the traditions of the past but also the responsibility to improve the systems they depend upon. This sense of responsibility pushes individuals to explore new ideas, challenge outdated norms, and build better opportunities for the future.

One of the most powerful aspects of learning is its ability to connect people. Through shared knowledge, people from different cultures, languages, and backgrounds can understand one another in deeper ways. A scientific discovery in one corner of the world can change the lives of millions across continents. Similarly, a story told in one language may inspire emotions in someone who does not even speak it, once it is translated or adapted. This universality of ideas shows that education is not limited by borders, but rather becomes stronger when shared openly.

Technology has accelerated the spread of knowledge like never before. A student with a smartphone today has access to more information than entire libraries of the past. However, access alone is not enough; the real challenge lies in teaching people how to use this knowledge effectively. Critical thinking, digital literacy, and ethical responsibility must be at the heart of modern education. Without these, the abundance of information can easily turn into confusion, misinformation, or even manipulation. Therefore, the role of teachers, mentors, and community leaders is more important than ever before.

At the same time, we must not forget that education is not only about academics. Emotional intelligence, empathy, and creativity are equally essential for building a balanced and meaningful life. A society that focuses only on competition and technical knowledge risks losing sight of humanity. True progress requires individuals who are not just intelligent, but also compassionate and responsible toward others.

In conclusion, education is both a personal journey and a collective mission. It empowers individuals to achieve their goals while also building stronger, fairer communities. By investing in education that balances knowledge with values, societies can prepare themselves for challenges and opportunities that lie ahead. Learning never ends; it evolves, grows, and adapts with every generation, ensuring that humanity continues to move forward with wisdom and hope.
""";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text(
          "Penverse",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: search action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Timer at the top
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1F1F5D),
            child: Text(
              "Reading Time: $_formattedTime",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Paragraph (scrollable)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Text(
                paragraph,
                style: GoogleFonts.merriweather(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
