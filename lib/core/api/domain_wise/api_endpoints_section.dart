class SectionEndpoints {
  static const base = "/sections";

  
  static String createSection() => "$base/create";
 
  static String updateSectionName(String sectionId) => "$base/update/$sectionId";

 
  static String getLibrarySections(String libraryId) => "$base/library/$libraryId";
 
  static String addBookToSection(String sectionId) => "$base/$sectionId/add-book";
 
  static String removeBookFromSection(String sectionId) => "$base/$sectionId/remove-book";
 
  static String deleteSection(String sectionId) => "$base/$sectionId";
 
  static String getSectionBooks(String sectionId) => "$base/$sectionId/books";
}
