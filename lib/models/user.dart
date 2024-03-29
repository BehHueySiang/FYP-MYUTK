class User {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? password;
  String? useraddress;
  String? otp;
  String? datereg;

  

  User(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.password,
      this.useraddress,
      this.otp,
      this.datereg});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    useraddress = json['useraddress'];
    otp = json['otp'];
    datereg = json['datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    data['useraddress'] = useraddress;
    data['otp'] = otp;
    data['datereg'] = datereg;
    return data;
  }
}