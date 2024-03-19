class Hotel {
  String? hotelid;
  String? userId;
  String? hotelname;
  String? bookurl;
  String? hotelurl;
  String? note;
  String? hotelstate;
  String? hotelbudget;
  String? hotelrate;
  
  

  Hotel(
      {this.hotelid,
      this.userId,
      this.hotelname,
      this.bookurl,
      this.hotelurl,
      this.note,
      this.hotelstate,
      this.hotelbudget,
      this.hotelrate});

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelid = json['Hotel_id'];
    userId = json['userid'];
    hotelname = json['Hotel_Name'];
    bookurl = json['Book_Url'];
    hotelurl = json['Hotel_Url'];
    note = json['Note'];
    hotelstate = json['Hotel_State'];
    hotelbudget = json['Hotel_Budget'];
    hotelrate = json['Hotel_Rate'];
    
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Hotel_id'] = hotelid;
    data['user_id'] = userId;
    data['Hotel_Name'] = hotelname;
    data['Book_Url'] = bookurl;
    data['Hotel_Url'] = hotelurl;
    data['Note'] = note;
    data['Hotel_State'] = hotelstate;
    data['Hotel_Budget'] = hotelbudget;
    data['Hotel_Rate'] = hotelrate;
    return data;
  }
}