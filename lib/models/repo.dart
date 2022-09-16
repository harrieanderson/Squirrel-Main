import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squirrel/models/usser_model.dart';

class Repo {
  static Future<UserModel> getUser(String uid) async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return UserModel(
        username: userData['username'],
        firstName: userData['firstname'],
        secondName: userData['secondname'],
        uid: userData['uid'],
        photoUrl: userData['photoUrl'],
        email: userData['email'],
        bio: userData['bio'],
        friends: userData['friends'],
        culls: userData['culls']);
  }
}
