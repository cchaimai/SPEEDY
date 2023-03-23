class UserModel {
  String firstName;
  String lastName;
  String email;
  String profilePic;
  String uid;
  String phoneNumber;
  String createAt;

  UserModel({
    required this.firstName, 
    required this.lastName, 
    required this.email, 
    required this.profilePic, 
    required this.uid, 
    required this.phoneNumber, 
    required this.createAt
    }
  );

  //from map
  factory UserModel.fromMap(Map<String, dynamic>map) {
    return UserModel(
      firstName: map['fisrtName'] ?? '', 
      lastName: map['lastName'] ?? '', 
      email: map['email'] ?? '', 
      profilePic: map['profilePic'] ?? '', 
      uid: map['uid'] ?? '', 
      phoneNumber: map['phoneNumber'] ?? '', 
      createAt: map['createAt'] ?? ''
    );
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "profilePic": profilePic,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createAt": createAt,
    };
  }
}