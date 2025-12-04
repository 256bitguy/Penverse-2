// lib/features/chapter/redux/chapter_actions.dart
import 'package:penverse/features/subjects/chapter/redux/chapter_model.dart';

import './chapter_state.dart';

class LoadChaptersAction {}

class LoadChaptersSuccessAction {
  final List<Chapter> chapters;
  LoadChaptersSuccessAction(this.chapters);
}

class LoadChaptersFailureAction {
  final String error;
  LoadChaptersFailureAction(this.error);
}

class LoadChaptersByBookAction {
  final String bookId;
  LoadChaptersByBookAction(this.bookId);
}
