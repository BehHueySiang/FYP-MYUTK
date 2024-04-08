class Budgetinfo {
  String? budgetid;
  String? userId;
  String? budgetname;
  String? budgetday;
  String? totalbudget;
 
  

  Budgetinfo(
      {this.budgetid,
      this.userId,
      this.budgetname,
      this.budgetday,
      this.totalbudget,
      });

  Budgetinfo.fromJson(Map<String, dynamic> json) {
    budgetid = json['Budget_id'];
    userId = json['userid'];
    budgetname = json['Budget_Name'];
    budgetday = json['Budget_Day'];
    totalbudget = json['Total_Budget']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Budget_id'] = budgetid;
    data['user_id'] = userId;
    data['Budget_Name'] = budgetname;
    data['Budget_Day'] = budgetday;
    data['Total_Budget'] = totalbudget;
  
    return data;
  }
}