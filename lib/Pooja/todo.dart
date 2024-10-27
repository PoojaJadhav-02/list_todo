class Todo {
  final String task;
  final DateTime date;
  bool isCompleted;
  final bool isHighPriority;
  final String category;

  Todo({
    required this.task,
    required this.date,
    this.isCompleted = false,
    required this.isHighPriority,
    required this.category,
  });
}