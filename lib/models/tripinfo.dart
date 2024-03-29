class Tripinfo {
  String? tripid;
  String? tripname;
  String? triptype;
  String? tripstate;
  String? tripday;
  String? userId;

 

  

  Tripinfo(
      {
      this.tripid,
      this.tripname,
      this.triptype,
      this.tripstate,
      this.tripday,
      this.userId,
     });

  Tripinfo.fromJson(Map<String, dynamic> json) {
    tripid = json['Trip_id'];
    tripname = json['Trip_Name'];
    triptype = json['Trip_Type'];
    tripstate = json['Trip_State'];
    tripday = json['Trip_Day'];
    userId = json['userid']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Trip_id'] = tripid;
    data['Trip_Name'] = tripname;
    data['Trip_Type'] = triptype;
    data['Trip_State'] = tripstate;
    data['Trip_Day'] = tripday;
    data['user_id'] = userId;
    return data;
  }
}