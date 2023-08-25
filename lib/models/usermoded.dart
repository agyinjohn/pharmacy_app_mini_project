class UserModel {
  final String name;
  final String email;
  final String uid;
  final String password;
  final String phone;
  final String profilePic;
  UserModel( {
    required this.name,
    required this.phone,
    required this.email,
    required this.uid,
    required this.password,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone':phone,
      'email': email,
      'uid': uid,
      'password': password,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '', 
      uid: map['uid'] ?? '',
      password: map['password'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }
}
