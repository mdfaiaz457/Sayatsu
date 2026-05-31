/// Defines the structure for pagination results
class PaginationResult<T> {
  final List<T> items;
  final int total;
  final int offset;
  final int limit;

  PaginationResult({
    required this.items,
    required this.total,
    required this.offset,
    required this.limit,
  });

  bool get hasNextPage => offset + limit < total;
  bool get hasPreviousPage => offset > 0;
  int get currentPage => (offset / limit).ceil();
  int get totalPages => (total / limit).ceil();
}

/// Result wrapper for API calls
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResult.success(this.data)
      : error = null,
        isSuccess = true;

  ApiResult.error(this.error)
      : data = null,
        isSuccess = false;

  factory ApiResult.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
    try {
      return ApiResult.success(fromJson(json));
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
