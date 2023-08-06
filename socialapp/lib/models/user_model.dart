class UserMoedl {
  String? userName;
  String? email;
  String? phone;
  String? userId;

  UserMoedl({this.userName, this.email, this.phone, this.userId});

  UserMoedl.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    email = json['email'];
    phone = json['phone'];
    userId = json['uid'];
  }
  Map<String, dynamic> toMap(UserMoedl model) {
    return {'name': model.userName, 'email': model.email, 'phone': model.phone, 'uid': model.userId};
  }
}
