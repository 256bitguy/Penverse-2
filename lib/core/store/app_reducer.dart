import '../../features/auth/auth_reducers.dart';
import '../../features/dailyenglish/vocabulary/vocab_reducer.dart';
import '../../features/dailyenglish/idioms/idioms_reducer.dart';
import '../../features/dailyenglish/phrasalVerbs/phrasal_verb_reducer.dart';
import '../../features/dailyenglish/editorials/editorial_reducer.dart';
import '../../features/currentaffairs/generalAwareness/banking_awareness_reducer.dart'; // ✅ NEW
import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    vocabState: vocabReducer(state.vocabState, action),
    idiomsState: idiomsReducer(state.idiomsState, action),
    phrasalVerbsState: phrasalVerbsReducer(state.phrasalVerbsState, action),
    editorialState: editorialReducer(state.editorialState, action),
    bankingAwarenessState:
        bankingAwarenessReducer(state.bankingAwarenessState, action), // ✅ NEW
  );
}
