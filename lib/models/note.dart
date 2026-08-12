class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  const Note({
    required this.id, required this.title, required this.description, required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  //convert query to object Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  //optional

}