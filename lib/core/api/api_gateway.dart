import 'api_client.dart';
import '../../features/dailyenglish/vocabulary/services/vocab_service.dart';
import '../../features/dailyenglish/editorials/services/editorials_services.dart';
import '../../features/dailyenglish/phrasalVerbs/services/phrases_services.dart';
import '../../features/dailyenglish/idioms/services/idioms_services.dart';
import '../../features/currentaffairs/generalAwareness/services/bankingAwarenessService.dart';

class ApiGateway {
  final VocabService vocabService;
  final EditorialService editorialService;
  final IdiomService idiomService;
  final PhrasalVerbService phrasalVerbService;
  final BankingAwarenessService bankingAwarenessService;

  ApiGateway._({
    required this.vocabService,
    required this.editorialService,
    required this.idiomService,
    required this.phrasalVerbService,
    required this.bankingAwarenessService
  });

  factory ApiGateway.create() {
    
    final client = ApiClient(); // internally create client
    return ApiGateway._(
      vocabService: VocabService(client),
      editorialService: EditorialService(client),
      idiomService: IdiomService(client),
      phrasalVerbService: PhrasalVerbService(client),
      bankingAwarenessService: BankingAwarenessService(client)
    );
  }
}
