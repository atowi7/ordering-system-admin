class NotificationModel {
  // final int id;
  final String title;
  final String text;
  final String createdAt;

  NotificationModel(
      {required this.title, required this.text, required this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        title: json['title'] as String,
        text: json['text'] as String,
        createdAt: json['create_at'] as String);
  }
}
