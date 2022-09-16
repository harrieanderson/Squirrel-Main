import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class UserModel {
//   String uid;
//   String email;
//   String firstName;
//   String secondName;

//   UserModel(
//       {required this.uid,
//       required this.email,
//       required this.firstName,
//       required this.secondName});

//   // data from server
//   factory UserModel.fromMap(map) {
//     return UserModel(
//       uid: map['uid'] ?? "",
//       email: map['email'] ?? "",
//       firstName: map['firstName'] ?? "",
//       secondName: map['secondName'] ?? "",
//     );
//   }

//   // sending data to our server

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//       'firstName': firstName,
//       'secondName': secondName,
//     };
//   }
// }
// STARTS HERE !!!

// class UserModel {
//   String email;
//   String uid;
//   String photoUrl;
//   String username;
//   String firstName;
//   String secondName;
//   String bio;
//   List friends;
//   int culls;

//   UserModel(
//       {required this.username,
//       required this.firstName,
//       required this.secondName,
//       required this.uid,
//       required this.photoUrl,
//       required this.email,
//       required this.bio,
//       required this.friends,
//       required this.culls});

//   // data from server
//   factory UserModel.fromSnap(map) {
//     return UserModel(
//       uid: map['uid'] ?? "",
//       email: map['email'] ?? "",
//       firstName: map['firstName'] ?? "",
//       secondName: map['secondName'] ?? "",
//       bio: '',
//       culls: 0,
//       friends: [],
//       photoUrl: '',
//       username: '',
//     );
//   }

//   // sending data to our server

//   Map<String, dynamic> toMap() {
//     return {
//       "username": username,
//       "uid": uid,
//       "email": email,
//       "photoUrl": photoUrl,
//       "bio": bio,
//       "friends": friends,
//       "culls": culls,
//       "firstname": firstName,
//       "secondname": secondName
//     };
//   }
// }

// djhvjwhvwhvwhwfhwiofhwiohfwohfiowhf

class UserModel {
  String email;
  String uid;
  String photoUrl;
  String username;
  String firstName;
  String secondName;
  String bio;
  List friends;
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

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        username: snapshot["username"],
        uid: snapshot["uid"],
        firstName: snapshot['firstName'],
        secondName: snapshot['secondName'],
        email: snapshot["email"],
        photoUrl: snapshot["photoUrl"],
        bio: snapshot["bio"],
        friends: snapshot["friends"],
        culls: snapshot['culls']);
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


// TODO:
  


