class NotificationQueue {
  List<String> _queue = [];

  void enqueue(String notif) {
    _queue.add(notif);
  }

  String? dequeue() {
    if (_queue.isEmpty) return null;
    return _queue.removeAt(0);
  }

  bool isEmpty() => _queue.isEmpty;
}
