enum UrgencyLevel { Low, Medium, High, Urgent, Immediate }

class Task {
  final String title;
  final String description;
  final DateTime date;
  final UrgencyLevel urgency;

  Task({required this.title, required this.description, required this.date, required this.urgency});
}