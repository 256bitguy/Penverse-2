// lib/features/notes/data/notes_service.dart

import 'notes_state.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class NotesService {
  final ApiClient client;

  NotesService(this.client);

  /// Fetch a single note by its ID
  Future<NoteModel> fetchNoteById(String noteId) async {
    print("Fetching note with ID: $noteId");

    final response = await client.get(ApiEndpoints.note(noteId));
    final body = response.data;

    print("Single Note API Response: $body");

    // Validate structure
    if (body is Map<String, dynamic> && body['data'] is List) {
      final dataList = body['data'] as List<dynamic>;

      if (dataList.isNotEmpty) {
        // Assuming you want the first note in the list
        final firstNote = Map<String, dynamic>.from(dataList.first);
        return NoteModel.fromJson(firstNote);
      } else {
        throw Exception("No notes found for noteId: $noteId");
      }
    }

    throw Exception("Unexpected response format: $body");
  }
}
