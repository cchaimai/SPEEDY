class UserModel {
  String firstName;
  String lastName;
  String email;
  String profilePic;
  String uid;
  String chat;
  String phoneNumber;
  List<String> cards;
  List<String> coupon;
  List<String> events;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.chat,
    required this.phoneNumber,
    required this.cards,
    required this.events,
    required this.coupon,
  });

  //from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['fisrtName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['uid'] ?? '',
      chat: map['chat'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      cards: List<String>.from(map['cards'] ?? []),
      events: List<String>.from(map['events'] ?? []),
      coupon: List<String>.from(map['coupon'] ?? []),
  
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
      "cards": cards,
      "events": events,
      "chat": chat,
      "coupon": coupon,
    };
  }
}
