class Des {
  String? DesId;
  String? userId;
  String? DesName;
  String? Url;
  String? OpenTime;
  String? CloseTime;
  String? SuggestTime;
  String? Activity;
  String? DesState;
  String? DesRate;
  String? DesBudget;
  

  Des(
      {this.DesId,
      this.userId,
      this.DesName,
      this.Url,
      this.OpenTime,
      this.CloseTime,
      this.SuggestTime,
      this.Activity,
      this.DesState,
      this.DesRate,
      this.DesBudget});

  Des.fromJson(Map<String, dynamic> json) {
    DesId = json['Des_id'];
    userId = json['userid'];
    DesName = json['Des_Name'];
    Url = json['Url'];
    OpenTime = json['Open_Time'];
    CloseTime = json['Close_Time'];
    SuggestTime = json['Suggest_Time'];
    Activity = json['Activity'];
    DesState = json['Des_State'];
    DesRate = json['Des_Rate'];
    DesBudget = json['Des_Budget'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Des_id'] = DesId;
    data['user_id'] = userId;
    data['Des_Name'] = DesName;
    data['Url'] = Url;
    data['Open_Time'] = OpenTime;
    data['Close_Time'] = CloseTime;
    data['Suggest_Time'] = SuggestTime;
    data['Activity'] = Activity;
    data['Des_State'] = DesState;
    data['Des_Rate'] = DesRate;
    data['Des_Budget'] = DesBudget;
    return data;
  }
}