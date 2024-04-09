class Usertrip {
  String? utripid;
  String? tripid;
  String? tripname;
  String? triptype;
  String? tripstate;
  String? tripday;
  String? userId;
  String? totaltripfee;
  

 

  

  Usertrip(
      {
      this.utripid,
      this.tripid,
      this.tripname,
      this.triptype,
      this.tripstate,
      this.tripday,
      this.userId,
      this.totaltripfee,

     });

  Usertrip.fromJson(Map<String, dynamic> json) {
    utripid = json['Utrip_id'];
    tripid = json['Trip_id'];
    tripname = json['Trip_Name'];
    triptype = json['Trip_Type'];
    tripstate = json['Trip_State'];
    tripday = json['Trip_Day'];
    userId = json['userid']; 
    totaltripfee = json['Total_Tripfee'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Utrip_id'] = utripid;
    data['Trip_id'] = tripid;
    data['Trip_Name'] = tripname;
    data['Trip_Type'] = triptype;
    data['Trip_State'] = tripstate;
    data['Trip_Day'] = tripday;
    data['user_id'] = userId;
    data['Total_Tripfee'] = totaltripfee;

    return data;
  }
}