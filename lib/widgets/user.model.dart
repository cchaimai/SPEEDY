class UserModel {
  String firstName;
  String lastName;
  String email;
  String profilePic;
  String uid;
  String phoneNumber;
  String createAt;
  List<String> cards;
  List<String> events;
  List<String> groups;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.phoneNumber,
    required this.createAt,
    required this.cards,
    required this.events,
    required this.groups,
  });

  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['fisrtName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createAt: map['createAt'] ?? '',
      cards: List<String>.from(map['cards'] ?? []),
      events: List<String>.from(map['events'] ?? []),
      groups: List<String>.from(map['groups'] ?? []),
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
      "cards": cards,
      "events": events,
      "groups": groups,
    };
  }
}
