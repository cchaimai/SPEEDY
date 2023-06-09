import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("mUsers");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  final CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("cards");
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference dateCollection =
      FirebaseFirestore.instance.collection("date");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
      "cards": [],
      "events": [],
    });
  }

  // getting user data
  Future gettingUserData(String phone) async {
    QuerySnapshot snapshot =
        await userCollection.where("phoneNumber", isEqualTo: phone).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "admin": "${id}_$userName",
      "members": [],
      "recentMessage": "",
      "recentMessageSender": "",
    });

    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    await userDocumentReference.update({"chat": groupDocumentReference.id});
    return groupDocumentReference.id;
  }

  // creating a card
  Future createCard(String userName, String id, String cardNum, String fname,
      String lname, String valid, String cvv) async {
    DocumentReference cardDocumentReference = await cardCollection.add({
      "owner": "$id",
      "fname": fname,
      "lname": lname,
      "cardNum": cardNum,
      "valid": valid,
      "cvv": cvv,
      "cardId": "",
    });

    await cardDocumentReference.update({
      "cardId": cardDocumentReference.id,
    });

    // update card in user account
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "cards": FieldValue.arrayUnion(["${cardDocumentReference.id}"])
    });
  }

  Future addDateTime(String id, String type, String date, String time,
      String model, String carId, String fname, String lname) async {
    DocumentReference dateDocumentReference = await dateCollection.doc(date);
    DocumentSnapshot dateDocumentSnapshot = await dateDocumentReference.get();
    if (!dateDocumentSnapshot.exists) {
      await dateDocumentReference.set({
        "date": date,
        "09:00": [],
        "10:00": [],
        "11:00": [],
        "12:00": [],
        "13:00": [],
        "14:00": [],
        "15:00": [],
        "16:00": [],
        "17:00": [],
      });
    }

    DocumentReference eventDocumentReference = await eventCollection.add({
      "timeId": "",
      "time": time,
      "date": date,
      "firstName": fname,
      "lastName": lname,
      "type": type,
      "model": model,
      "owner": uid,
      "carId": carId,
      "status": "กำลังดำเนินการ"
    });

    await eventDocumentReference.update({
      "timeId": eventDocumentReference.id,
    });

    await dateDocumentReference.update({
      "$time": FieldValue.arrayUnion(["${eventDocumentReference.id}"]),
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    await userDocumentReference.update({
      "events": FieldValue.arrayUnion(["${eventDocumentReference.id}"])
    });
    return eventDocumentReference.id;
  }

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re join
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  //
}
