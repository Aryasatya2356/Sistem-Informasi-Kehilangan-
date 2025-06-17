import 'barang.dart';

class UndoStack {
  List<Barang> _stack = [];

  void push(Barang barang) {
    _stack.add(barang);
  }

  Barang? undo() {
    if (_stack.isEmpty) return null;
    return _stack.removeLast();
  }

  bool isEmpty() => _stack.isEmpty;
}
