class Todo {
  final String title;
  final String description;
  final String date;
  final String? userId;
  final String? id;

  Todo(
      {required this.title,
      required this.description,
      required this.date,
      this.userId,
      this.id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      userId: json['user_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'user_id': userId,
        'id': id,
      };
}
