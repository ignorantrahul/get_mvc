// Extension methods for string conversion
extension StringExtension on String {
  String toUpperCamelCase() {
    return split(' ').map((word) => word.capitalize()).join();
  }

  static String toLowerCamelCase(String str) {
    final words = str.split(' ').map((word) => word.toLowerCase()).toList();
    return '${words[0]}${words.sublist(1).map((word) => word.capitalize()).join()}';
  }

  String toLowercaseWithUnderscores() {
    return replaceAll(' ', '_').toLowerCase();
  }
}

// Capitalize extension method
extension CapitalizeExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
