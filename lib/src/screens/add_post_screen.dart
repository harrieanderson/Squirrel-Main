import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:squirrel/models/post.dart';
import 'package:squirrel/models/repo.dart';

import 'package:squirrel/models/usser_model.dart';
import 'package:squirrel/services/database.dart';
import 'package:squirrel/services/firestore_methods.dart';
import 'package:squirrel/services/storage_methods.dart';

import 'package:squirrel/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  final String uid;
  const AddPostScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late var _isLoggedOnUser =
      userModel!.uid == FirebaseAuth.instance.currentUser;
  Uint8List? _file;
  bool _isLoading = false;
  UserModel? userModel;

  late String _postText;

  void selectImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _file = file;
    });
  }

  void makePost(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _postText,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
          context,
          'posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a post'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        actions: [
          IconButton(
              constraints: BoxConstraints.expand(
                width: 50,
              ),
              icon: Text(
                'Post',
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                setState(() {});

                if (_postText.isNotEmpty) {
                  String image;
                  if (_file == null) {
                    image = '';
                  } else {
                    image = await StorageMethods()
                        .uploadImageToStorage('posts', _file!, true);
                    showSnackBar(
                      context,
                      'posted!',
                    );
                  }
                  Post post = Post(
                    authorId: widget.uid,
                    text: _postText,
                    image: image,
                    timestamp: Timestamp.fromDate(DateTime.now()),
                    likes: 0,
                  );
                  showSnackBar(context, 'posted!');
                  DatabaseMethods.createPost(post);
                  Navigator.pop(context);
                }
                setState(() {
                  _isLoading = false;
                });
              }),
          SizedBox(
            height: 20,
          ),
          _isLoading ? CircularProgressIndicator() : SizedBox.shrink()
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: FutureBuilder<UserModel>(
              future: Repo.getUser(widget.uid),
              builder: (context, snapshot) {
                final userModel = snapshot.data;
                if (userModel == null) {
                  return Container();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userModel.photoUrl,
                        ),
                      ),
                    ),
                    Text(
                      userModel.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "What's happening?",
              suffixIcon: GestureDetector(
                onTap: () => selectImage(),
                child: Icon(
                  Icons.image,
                ),
              ),
            ),
            onChanged: (value) {
              _postText = value;
            },
          ),
          SizedBox(
            height: 3,
          ),
          _file == null
              ? Container()
              : Column(
                  children: [
                    Container(
                      height: 200,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.memory(_file!),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
