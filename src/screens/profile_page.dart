// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/models/post.dart';
import 'package:squirrel/models/repo.dart';
import 'package:squirrel/models/usser_model.dart';
import 'package:squirrel/services/database.dart';
import 'package:squirrel/src/widgets/PostContainer.dart';
import 'package:squirrel/utils/utils.dart';

const _kAvatarRadius = 45.0;
const _kAvatarPadding = 8.0;

class ProfilePageUi extends StatefulWidget {
  final String uid;
  final String visitedUserId;

  const ProfilePageUi(
      {Key? key, required this.visitedUserId, required this.uid})
      : super(key: key);

  @override
  _ProfilePageUiState createState() => _ProfilePageUiState();
}

class _ProfilePageUiState extends State<ProfilePageUi> {
  late final _isOwnProfilePage = widget.visitedUserId == widget.uid;
  Uint8List? _image;
  UserModel? userModel;

  List<Post> _allPosts = [];

  Widget showProfilePosts(UserModel author) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _allPosts.length,
        itemBuilder: (context, index) {
          return PostContainer(
            post: _allPosts[index],
            author: author,
            currentUserId: widget.uid,
          );
        },
      ),
    );
  }

  @override
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  getAllPosts() async {
    List<Post> userPosts =
        await DatabaseMethods.getUserPosts(widget.visitedUserId);
    if (mounted) {
      setState(() {
        _allPosts = userPosts;
      });
    }
  }

  void initState() {
    super.initState();
    getAllPosts();
  }

  // gets data from Firebase

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            color: Colors.black,
            iconSize: 35,
          ),
        ],
      ),
      body: FutureBuilder<UserModel>(
          future: Repo.getUser(widget.uid),
          builder: (context, snapshot) {
            final userModel = snapshot.data;

            if (userModel == null) {
              return Container();
            }

            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(_kAvatarPadding),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userModel.photoUrl),
                        radius: _kAvatarRadius,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          userModel.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(userModel.bio)
                      ],
                    ),
                  ],
                ),
                if (_isOwnProfilePage)
                  Container()
                else
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Colors.green, fontSize: 15),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        onPressed: () => {},
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Add friend',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        onPressed: () => {},
                        icon: Icon(
                          Icons.mail,
                        ),
                        label: Text(
                          'Message',
                        ),
                      ),
                    ],
                  ),
                Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 131,
                    ),
                    Column(
                      children: [
                        Text(
                          userModel.culls.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          'Culls',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              userModel.culls.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              'Friends',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                showProfilePosts(
                  userModel,
                ),
              ],
            );
          }),
    );
  }
}
