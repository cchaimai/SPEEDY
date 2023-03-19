class UserModel {
  String fisrtName;
  String lastName;
  String email;
  String profilePic;
  String uid;
  String phoneNumber;
  String createAt;

  UserModel({
    required this.fisrtName, 
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
      fisrtName: map['fisrtName'] ?? '', 
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
      "fisrtName": fisrtName,
      "lastName": lastName,
      "email": email,
      "profilePic": profilePic,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createAt": createAt,
    };
  }
}