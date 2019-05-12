class User {
  String email;
  String password;
  String firstName;
  String lastName;

  User({this.email, this.password, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }
}
