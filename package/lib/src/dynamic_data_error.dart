class DynamicDataError {
  final Object error;
  final StackTrace? stackTrace;

  DynamicDataError({
    required this.error,
    required this.stackTrace,
  });
}
