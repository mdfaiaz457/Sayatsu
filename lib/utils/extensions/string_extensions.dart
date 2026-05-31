/// Extension methods for String
extension StringExtensions on String {
  /// Capitalize first letter
  String get capitalize => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  
  /// Check if string is a valid URL
  bool get isValidUrl {
    try {
      Uri.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Truncate string to specified length
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}
