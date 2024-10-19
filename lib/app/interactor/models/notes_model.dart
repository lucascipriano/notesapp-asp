class NotesModel {
  final String title;
  final String content;
  final int id;

  NotesModel({required this.id, required this.title, required this.content});
  NotesModel copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return NotesModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content);
  }
}
