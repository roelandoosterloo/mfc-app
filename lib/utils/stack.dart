import 'dart:collection';

class IStack<T> {
  final Queue _stack;

  Queue<T> _cloneStack() {
    return Queue.from(_stack);
  }

  IStack(Iterable<T>? elements)
      : _stack = elements != null ? Queue.of(elements) : Queue();

  IStack<T> push(T element) {
    Queue<T> b = _cloneStack();
    b.addLast(element);
    return IStack(b);
  }

  IStack<T> pop() {
    Queue<T> b = _cloneStack();
    b.removeLast();
    return IStack(b);
  }

  T? peek() {
    if (_stack.isNotEmpty) return _stack.last;
  }

  void clear() {
    return _stack.clear();
  }

  bool get isEmpty => _stack.isEmpty;

  int get length => _stack.length;

  List<T> toList() {
    return _cloneStack().toList();
  }
}
