class Des {
  String? desid;
  String? userId;
  String? desname;
  String? url;
  String? opentime;
  String? closetime;
  String? suggesttime;
  String? activity;
  String? desstate;
  String? desrate;
  String? desbudget;
  String? latitude;
  String? longtitude;
  

  Des(
      {this.desid,
      this.userId,
      this.desname,
      this.url,
      this.opentime,
      this.closetime,
      this.suggesttime,
      this.activity,
      this.desstate,
      this.desrate,
      this.desbudget,
      this.latitude,
      this.longtitude
      });

  Des.fromJson(Map<String, dynamic> json) {
    desid = json['Des_id'];
    userId = json['userid'];
    desname = json['Des_Name'];
    url = json['Url'];
    opentime = json['Open_Time'];
    closetime = json['Close_Time'];
    suggesttime = json['Suggest_Time'];
    activity = json['Activity'];
    desstate = json['Des_State'];
    desrate = json['Des_Rate'];
    desbudget = json['Des_Budget'];
    latitude = json['Latitude'];
    longtitude = json['Longtitude'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Des_id'] = desid;
    data['user_id'] = userId;
    data['Des_Name'] = desname;
    data['Url'] = url;
    data['Open_Time'] = opentime;
    data['Close_Time'] = closetime;
    data['Suggest_Time'] = suggesttime;
    data['Activity'] = activity;
    data['Des_State'] = desstate;
    data['Des_Rate'] = desrate;
    data['Des_Budget'] = desbudget;
    data['Latitude'] = latitude;
    data['Longtitude'] = longtitude;
    return data;
  }
}