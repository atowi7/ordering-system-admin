class NotificationModel {
  final int id;
  final String title;
  final String text;
  final String createdAt;
  final String userId;

  NotificationModel(
      {required this.id,
      required this.title,
      required this.text,
      required this.createdAt,
      required this.userId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      createdAt: json['create_at'] as String,
      userId: json['userid'] as String,
    );
  }
}
