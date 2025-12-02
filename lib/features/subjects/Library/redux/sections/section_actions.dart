import 'section_state.dart';

class LoadSectionsAction {}

class LoadSectionsSuccessAction {
  final List<Section> sections;
  LoadSectionsSuccessAction(this.sections);
}

class LoadSectionsFailureAction {
  final String error;
  LoadSectionsFailureAction(this.error);
}

class LoadBooksBySectionAction {
  final String sectionId;
  LoadBooksBySectionAction(this.sectionId);
}