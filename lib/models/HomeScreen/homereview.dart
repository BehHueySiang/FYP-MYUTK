class Homereview {
  String? hreviewid;
  String? reviewid;
  String? userId;
  String? reviewname;
  String? comment;

  Homereview(
      {this.hreviewid,
      this.reviewid,
      this.userId,
      this.reviewname,
      this.comment,});

  Homereview.fromJson(Map<String, dynamic> json) {
    hreviewid = json['Hreview_id'];
    reviewid = json['Review_id'];
    userId = json['userid'];
    reviewname = json['Review_Name'];
    comment = json['Comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Hreview_id'] = hreviewid;
    data['Review_id'] = reviewid;
    data['user_id'] = userId;
    data['Review_Name'] = reviewname;
    data['Comment'] = comment;
    return data;
  }
}