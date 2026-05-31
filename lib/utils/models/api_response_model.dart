/// API Response wrapper
class ApiResponse<T> {
  final T data;
  final int statusCode;
  final String? message;

  ApiResponse({
    required this.data,
    required this.statusCode,
    this.message,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

/// Pagination metadata
class PaginationMeta {
  final int total;
  final int limit;
  final int offset;
  final int lastPage;

  PaginationMeta({
    required this.total,
    required this.limit,
    required this.offset,
    required this.lastPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 20,
      offset: json['offset'] ?? 0,
      lastPage: json['lastPage'] ?? 1,
    );
  }
}
