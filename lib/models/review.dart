class Review {
  String? reviewid;
  String? userId;
  String? reviewname;
  String? comment;
 
  
  

  Review(
      {this.reviewid,
      this.userId,
      this.reviewname,
      this.comment,});

  Review.fromJson(Map<String, dynamic> json) {
    reviewid = json['Review_id'];
    userId = json['userid'];
    reviewname = json['Review_Name'];
    comment = json['Comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Review_id'] = reviewid;
    data['user_id'] = userId;
    data['Review_Name'] = reviewname;
    data['Comment'] = comment;
    return data;
  }
}