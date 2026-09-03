import 'dart:convert';

class Note {
  final String id;
  final String title;
  final String description;

  Note({required this.id, required this.title, required this.description});

  // Convert Note to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }

  // Convert JSON to Note
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  // Convert List of Notes to JSON String
  static String notesListToJson(List<Note> notes) {
    return jsonEncode(notes.map((note) => note.toJson()).toList());
  }

  // Convert JSON String to List of Notes
  static List<Note> notesListFromJson(String jsonString) {
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((item) => Note.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
