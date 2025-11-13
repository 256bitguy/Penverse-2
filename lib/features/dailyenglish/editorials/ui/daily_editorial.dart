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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        final EditorialItem item = vm.items[0];

        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: AppColors.scaffoldBackground),
                  child: Text(
                    "Menu",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(title: Text("Option 1")),
                ListTile(title: Text("Option 2")),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            title: const Text(
              "Penverse",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    final store =
                        StoreProvider.of<AppState>(context, listen: false);
                    EditorialViewModel.fromStore(store)
                        .loadEditorialByDate(pickedDate);
                    print("date picked $pickedDate");
                  }
                },
              ),
            ],
          ),
          body: vm.items.isEmpty
              ? const Center(
                  child: Text(
                    "No Editorial found \n Try Selecting other date",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              : Container(
                color: AppColors.cardBackground,
                  child: Column(
                    //  backgroundColor: AppColors.scaffoldBackground,
                    children: [
                      // Timer at the top
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        color: AppColors.cardBackground,
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

                      // Paragraphs (scrollable)
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

                              // Render paragraphs
                              for (final para in item.paragraph) ...[
                                Text(
                                  para,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 18,
                                    height: 1.6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 16),
                              ],

                              const SizedBox(height: 24),

                              // Quiz button
                              if (item.questions.isNotEmpty)
                                Center(
                                  // backgroundColor: AppColors.scaffoldBackground,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.textSecondary.withOpacity(0.2),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              QuizScreen(item: item),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Start Quiz",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
