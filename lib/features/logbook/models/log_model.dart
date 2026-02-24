class LogModel {
  final String user;
  final String title;
  final String date;
  final String description;

  LogModel({
    required this.user,
    required this.title,
    required this.date,
    required this.description,
  });

  // Untuk Tugas HOTS: Konversi Map (JSON) ke Object
  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      user: map['user'],
      title: map['title'],
      date: map['date'],
      description: map['description'],
    );
  }

  // Konversi Object ke Map (JSON) untuk disimpan
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'title': title,
      'date': date,
      'description': description,
    };
  }
}
