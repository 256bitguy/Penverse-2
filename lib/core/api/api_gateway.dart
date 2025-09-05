import 'api_client.dart';
import '../../features/dailyenglish/vocabulary/services/vocab_service.dart';
import '../../features/dailyenglish/editorials/services/editorials_services.dart';
import '../../features/dailyenglish/phrasalVerbs/services/phrases_services.dart';
import '../../features/dailyenglish/idioms/services/idioms_services.dart';

class ApiGateway {
  final VocabService vocabService;
  final EditorialService editorialService;
  final IdiomService idiomService;
  final PhrasalVerbService phrasalVerbService;

  ApiGateway._({
    required this.vocabService,
    required this.editorialService,
    required this.idiomService,
    required this.phrasalVerbService
  });

  factory ApiGateway.create() {
      print("🚀 ApiGateway created!");
    final client = ApiClient(); // internally create client
    return ApiGateway._(
      vocabService: VocabService(client),
      editorialService: EditorialService(client),
      idiomService: IdiomService(client),
      phrasalVerbService: PhrasalVerbService(client)
    );
  }
}
