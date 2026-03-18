class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  const ApiResponse({required this.success, this.data, this.message, this.statusCode});
  factory ApiResponse.success(T data, {String? message, int statusCode = 200}) => ApiResponse(success: true, data: data, message: message, statusCode: statusCode);
  factory ApiResponse.error(String message, {int? statusCode}) => ApiResponse(success: false, message: message, statusCode: statusCode);
  factory ApiResponse.fromJson(Map<String, dynamic> j, T Function(dynamic)? mapper) => ApiResponse(success: j['success'] as bool? ?? true, data: j['data'] != null && mapper != null ? mapper(j['data']) : null, message: j['message'] as String?, statusCode: j['statusCode'] as int?);
}
