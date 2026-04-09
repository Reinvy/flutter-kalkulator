class HistoryEntry {
  final String expression;
  final String result;
  final DateTime timestamp;

  HistoryEntry({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  String toStorageString() => '$expression\x1F$result\x1F${timestamp.millisecondsSinceEpoch}';

  factory HistoryEntry.fromStorageString(String s) {
    final parts = s.split('\x1F');
    if (parts.length < 3) {
      return HistoryEntry(
        expression: parts.isNotEmpty ? parts[0] : '',
        result: parts.length > 1 ? parts[1] : '',
        timestamp: DateTime.now(),
      );
    }
    return HistoryEntry(
      expression: parts[0],
      result: parts[1],
      timestamp: DateTime.fromMillisecondsSinceEpoch(int.parse(parts[2])),
    );
  }
}
