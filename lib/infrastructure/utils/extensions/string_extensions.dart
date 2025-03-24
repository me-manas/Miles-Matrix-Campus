extension StringExtensions on String {
  String toPascalCase() {
    if (isEmpty) {
      return '';
    }

    // Split the string by non-alphanumeric characters
    List<String> words =
        split(
          RegExp(r'[^a-zA-Z0-9]'),
        ).where((word) => word.isNotEmpty).toList();

    // Capitalize first letter of each word and join them
    return words
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() +
              (word.length > 1 ? word.substring(1).toLowerCase() : '');
        })
        .join('');
  }
}
