class HttpError extends Error {
  final int code;
  final String message;

  HttpError({
    required this.code,
    required this.message,
  });

  @override
  toString() {
    return message;
  }
}
