class UserModel{
  String userId;
  String firstName;
  String lastName;
  String email;
  String phone;

  UserModel(this.userId, this.firstName, this.lastName, this.email, this.phone );
  Map<String, dynamic> toJson() =>{
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone
  };
}