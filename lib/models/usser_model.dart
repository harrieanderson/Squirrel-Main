// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // class UserModel {
// //   String uid;
// //   String email;
// //   String firstName;
// //   String secondName;

// //   UserModel(
// //       {required this.uid,
// //       required this.email,
// //       required this.firstName,
// //       required this.secondName});

// //   // data from server
// //   factory UserModel.fromMap(map) {
// //     return UserModel(
// //       uid: map['uid'] ?? "",
// //       email: map['email'] ?? "",
// //       firstName: map['firstName'] ?? "",
// //       secondName: map['secondName'] ?? "",
// //     );
// //   }

// //   // sending data to our server

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'uid': uid,
// //       'email': email,
// //       'firstName': firstName,
// //       'secondName': secondName,
// //     };
// //   }
// // }
// // STARTS HERE !!!

// // class UserModel {
// //   String email;
// //   String uid;
// //   String photoUrl;
// //   String username;
// //   String firstName;
// //   String secondName;
// //   String bio;
// //   List friends;
// //   int culls;

// //   UserModel(
// //       {required this.username,
// //       required this.firstName,
// //       required this.secondName,
// //       required this.uid,
// //       required this.photoUrl,
// //       required this.email,
// //       required this.bio,
// //       required this.friends,
// //       required this.culls});

// //   // data from server
// //   factory UserModel.fromSnap(map) {
// //     return UserModel(
// //       uid: map['uid'] ?? "",
// //       email: map['email'] ?? "",
// //       firstName: map['firstName'] ?? "",
// //       secondName: map['secondName'] ?? "",
// //       bio: '',
// //       culls: 0,
// //       friends: [],
// //       photoUrl: '',
// //       username: '',
// //     );
// //   }

// //   // sending data to our server

// //   Map<String, dynamic> toMap() {
// //     return {
// //       "username": username,
// //       "uid": uid,
// //       "email": email,
// //       "photoUrl": photoUrl,
// //       "bio": bio,
// //       "friends": friends,
// //       "culls": culls,
// //       "firstname": firstName,
// //       "secondname": secondName
// //     };
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String uid;
  String photoUrl;
  String username;
  String firstName;
  String secondName;
  String bio;
  List<String> friends;
  int culls;

  UserModel(
      {required this.username,
      required this.firstName,
      required this.secondName,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.friends,
      required this.culls});

  factory UserModel.fromDoc(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    final model = UserModel(
        username: snapshot["username"],
        uid: snapshot["uid"],
        firstName: snapshot["firstname"],
        secondName: snapshot["secondname"],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],

// // TODO: sort friends array
        // friends: <String>[],
        friends: <String>[],
        culls: snapshot['culls']);
    // int.tryParse(snapshot['culls']) ?? 0;
    // print(' MODE MODEL MODEL $model');
    return model;
  }

  Map<String, dynamic> toMap() => {
        "username": username,
        "firstname": firstName,
        "secondname": secondName,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "friends": friends,
        "culls": culls,
      };
}


// // TODO:
  


