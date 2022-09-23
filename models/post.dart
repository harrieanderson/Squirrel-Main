import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  // String username;
  String authorId;
  String text;
  String image;
  Timestamp timestamp;
  int likes;

  Post({
    // required this.username,
    required this.authorId,
    required this.text,
    required this.image,
    required this.timestamp,
    required this.likes,
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      // username: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      image: doc['image'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
    );
  }
}
