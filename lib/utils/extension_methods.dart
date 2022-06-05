extension EditList on List {
  List<T> editList<T>(T? item) {
    if (item == null) {
      return this as List<T>;
    } else if (contains(item)) {
      return List<T>.from(this)..remove(item);
    } else {
      return List<T>.from(this)..add(item);
    }
  }
}
