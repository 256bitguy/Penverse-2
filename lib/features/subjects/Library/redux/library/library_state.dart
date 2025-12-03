class LibraryState {
  final String libraryName;
  final String libraryId;
  final bool isLoading;
  final String? error;

  LibraryState({
    required this.libraryName,
    required this.libraryId,
    required this.isLoading,
    this.error,
  });

  factory LibraryState.initial() {
    return LibraryState(
      libraryName: "My Library",
      libraryId: "0",
      isLoading: false,
      error: null,
    );
  }

  LibraryState copyWith({
    String? libraryName,
    String? libraryId,
    bool? isLoading,
    String? error,
  }) {
    return LibraryState(
      libraryName: libraryName ?? this.libraryName,
       libraryId: libraryId ?? this.libraryId,           
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory LibraryState.fromJson(Map<String, dynamic> json) {
    return LibraryState(
      libraryName: json['libraryName'] ?? "My Library",
      libraryId: json['libraryId'] ?? "",
      isLoading: false,
      error: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "libraryName": libraryName,
      "libraryId":libraryId,
    };
  }
}
