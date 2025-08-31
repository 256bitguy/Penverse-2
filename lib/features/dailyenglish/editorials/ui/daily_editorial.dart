import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/store/app_state.dart';
import '../editorial_viewmodel.dart';  
import '../editorial_state.dart';  
import '../ui/component/quiz_screen.dart';
class ParagraphScreen extends StatefulWidget {
  const ParagraphScreen({super.key});

  @override
  State<ParagraphScreen> createState() => _ParagraphScreenState();
}

class _ParagraphScreenState extends State<ParagraphScreen> {
  late Timer _timer;
  int _seconds = 0;

@override
void initState() {
  super.initState();

  // Start timer
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      _seconds++;
    });
  });

  // Trigger loadEditorial safely after the first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    EditorialViewModel.fromStore(store).loadEditorial();
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
    return StoreConnector<AppState, EditorialViewModel>(
      distinct: true,
      converter: (store) => EditorialViewModel.fromStore(store),
      builder: (context, vm) {
        if (false) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (vm.error != null) {
          return Scaffold(
            body: Center(child: Text("Error: ${vm.error}")),
          );
        }

        if (vm.items.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No editorial content found")),
          );
        }

        // Take first editorial item for display
        final EditorialItem item = vm.items[0];

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
                onPressed: () {},
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          item.paragraph,
          style: GoogleFonts.merriweather(
            fontSize: 18,
            height: 1.6,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24),

        // 👇 Instead of showing questions here:
        if (item.questions.isNotEmpty)
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(item: item),
                  ),
                );
              },
              child: const Text("Start Quiz", style: TextStyle(color: Colors.white)),
            ),
          ),
      ],
    ),
  ),
),

            ],
          ),
        );
      },
    );
  }
}
