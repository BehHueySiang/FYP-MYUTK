class Budget {
  String? budgetid;
  String? userId;
  String? budgettitle;
  String? day;
  String? totalbudget;
 
  

  Budget(
      {this.budgetid,
      this.userId,
      this.budgettitle,
      this.day,
      this.totalbudget,
      });

  Budget.fromJson(Map<String, dynamic> json) {
    budgetid = json['Budget_id'];
    userId = json['userid'];
    budgettitle = json['Budgte_Title'];
    day = json['Day'];
    totalbudget = json['Total_Budget']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Budget_id'] = budgetid;
    data['user_id'] = userId;
    data['Budget_Title'] = budgettitle;
    data['Day'] = day;
    data['Total_Budget'] = totalbudget;
  
    return data;
  }
}