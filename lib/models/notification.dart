class Notify {
  String? notificationid;
  String? userId;
  String? title;
  String? content;

  Notify(
      {this.notificationid,
      this.userId,
      this.title,
      this.content,});

  Notify.fromJson(Map<String, dynamic> json) {
    notificationid = json['NotificationId'];
    userId = json['userid'];
    title = json['Title'];
    content = json['Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NotificationId'] = notificationid;
    data['user_id'] = userId;
    data['Title'] = title;
    data['Content'] = content;
    return data;
  }
}