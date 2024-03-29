class Tripday {
  String? dayid;
  String? dayname;
  String? desid;
  String? userId;
  String? tripid;
  String? desname;
  String? url;
  String? opentime;
  String? closetime;
  String? suggesttime;
  String? activity;
  String? desstate;
  String? desrate;
  String? desbudget;
  String? tripname;
  String? triptype;
  String? tripstate;
  String? tripday;
   
  

  Tripday(
      {this.dayid,
      this.dayname, 
      this.desid,
      this.userId,
      this.tripid,
      this.desname,
      this.url,
      this.opentime,
      this.closetime,
      this.suggesttime,
      this.activity,
      this.desstate,
      this.desrate,
      this.desbudget,
      this.tripname,
      this.triptype,
      this.tripstate,
      this.tripday,});

  Tripday.fromJson(Map<String, dynamic> json) {
    dayid = json['Day_id'];
    dayname = json['Day_Name'];
    desid = json['Des_id'];
    userId = json['userid'];
    tripid = json['Trip_id'];
    desname = json['Des_Name'];
    url = json['Url'];
    opentime = json['Open_Time'];
    closetime = json['Close_Time'];
    suggesttime = json['Suggest_Time'];
    activity = json['Activity'];
    desstate = json['Des_State'];
    desrate = json['Des_Rate'];
    desbudget = json['Des_Budget'];
    tripname = json['Trip_Name'];
    triptype = json['Trip_Type'];
    tripstate = json['Trip_State'];
    tripday = json['Trip_Day'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Day_id'] = dayid;
    data['Day_Name'] = dayname;
    data['Des_id'] = desid;
    data['user_id'] = userId;
    data['Trip_id'] = tripid;
    data['Des_Name'] = desname;
    data['Url'] = url;
    data['Open_Time'] = opentime;
    data['Close_Time'] = closetime;
    data['Suggest_Time'] = suggesttime;
    data['Activity'] = activity;
    data['Des_State'] = desstate;
    data['Des_Rate'] = desrate;
    data['Des_Budget'] = desbudget;
    data['Trip_Name'] = tripname;
    data['Trip_Type'] = triptype;
    data['Trip_State'] = tripstate;
    data['Trip_Day'] = tripday;
    return data;
  }
}