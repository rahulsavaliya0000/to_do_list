

class TodoItem {
  String text;
  bool isDone;

  TodoItem({required this.text, required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isDone': isDone,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      text: map['text'],
      isDone: map['isDone'],
    );
  }
}
