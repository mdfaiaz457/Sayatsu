/// Error handling utilities
class ErrorHandler {
  /// Parse error to user-friendly message
  static String getErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    }
    
    final errorString = error.toString();
    
    if (errorString.contains('SocketException')) {
      return 'No internet connection';
    } else if (errorString.contains('TimeoutException')) {
      return 'Request timed out. Please try again';
    } else if (errorString.contains('404')) {
      return 'Resource not found';
    } else if (errorString.contains('500')) {
      return 'Server error. Please try again later';
    } else {
      return 'Something went wrong. Please try again';
    }
  }
  
  /// Log error with context
  static void logError(dynamic error, StackTrace? stackTrace, {String? context}) {
    print('ERROR${context != null ? ' [$context]' : ''}: $error');
    if (stackTrace != null) {
      print('STACK TRACE: $stackTrace');
    }
  }
}
