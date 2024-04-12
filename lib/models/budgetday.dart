class Budgetday {
  String? bdayid;
  String? userId;
  String? budgetid;
  String? bdayname;
  String? expendtype;
  String? expendname;
  String? expenddate;
  String? expendamount;
  String? budgetname;
  String? budgetday;
  String? totalbudget;
  String? totalexpenditure;
 
  

  Budgetday(
      {
      this.bdayid,
      this.userId,
      this.budgetid,
      this.bdayname,
      this.expendtype,
      this.expendname,
      this.expenddate,
      this.expendamount,
      this.budgetname,
      this.budgetday,
      this.totalbudget,
      this.totalexpenditure

      });

  Budgetday.fromJson(Map<String, dynamic> json) {
    
    bdayid = json['Bday_id'];
    userId = json['userid'];
    budgetid = json['Budget_id'];
    bdayname = json['Bday_Name'];
    expendtype = json['Expend_Type'];
    expendname = json['Expend_Name'];
    expenddate = json['Expend_Date'];
    expendamount = json['Expend_Amount'];
    budgetname = json['Budget_Name'];
    budgetday = json['Budget_Day'];
    totalbudget = json['Total_Budget']; 
    totalexpenditure = json['Total_Expenditure'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Bday_id'] = bdayid;
    data['user_id'] = userId;
    data['Budget_id'] = budgetid;
    data['Bday_Name'] = bdayname;
    data['Expend_Type'] = expendtype;
    data['Expend_Name'] = expendname;
    data['Expend_Date'] = expenddate;
    data['Expend_Amount'] = expendamount;
    data['Budget_Name'] = budgetname;
    data['Budget_Day'] = budgetday;
    data['Total_Budget'] = totalbudget;
    data['Total_Expenditure'] = totalexpenditure;

    return data;
  }
}