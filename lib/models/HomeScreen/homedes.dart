class Homedes {
  String? hdesid;
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
  
  Homedes(
      {this.hdesid, 
      this.desid,
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
      });

  Homedes.fromJson(Map<String, dynamic> json) {
    hdesid = json['Hdes_id'];
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
    
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Hdes_id'] = hdesid;
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
    return data;
  }
}