class LimitExeption implements Exception {
  final String message;

  LimitExeption(this.message);

  @override
  String toString() => 'LimitExeption: $message';
}
