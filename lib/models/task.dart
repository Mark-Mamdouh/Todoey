class Task {
  String name;
  bool isDone;

  Task(String name, bool isDone) {
    this.name = name;
    this.isDone = isDone;
  }

  // switch between done and not done
  void toggleDone() {
    isDone = !isDone;
  }
}