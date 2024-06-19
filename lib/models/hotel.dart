class Hotel {
  String? hotelid;
  String? userId;
  String? hotelname;
  String? bookingurl;
  String? note;
  String? hotelstate;
  String? hotelbudget;
  String? hotelrate;
  
  

  Hotel(
      {this.hotelid,
      this.userId,
      this.hotelname,
      this.bookingurl,
      this.note,
      this.hotelstate,
      this.hotelbudget,
      this.hotelrate});

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelid = json['Hotel_id'];
    userId = json['userid'];
    hotelname = json['Hotel_Name'];
    bookingurl = json['Booking_Url'];
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
    data['Booking_Url'] = bookingurl;
    data['Note'] = note;
    data['Hotel_State'] = hotelstate;
    data['Hotel_Budget'] = hotelbudget;
    data['Hotel_Rate'] = hotelrate;
    return data;
  }
}