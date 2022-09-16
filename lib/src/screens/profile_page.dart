// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:squirrel_main/models/post.dart';
import 'package:squirrel_main/models/user.dart';
import 'package:squirrel_main/repositories/user_repository.dart';
import 'package:squirrel_main/services/auth.dart';
import 'package:squirrel_main/services/database.dart';
import 'package:squirrel_main/src/screens/edit_profile_screen.dart';
import 'package:squirrel_main/src/screens/login_screen.dart';
import 'package:squirrel_main/src/widgets/post_container.dart';
import 'package:squirrel_main/utils/utils.dart';

const _kAvatarRadius = 45.0;
const _kAvatarPadding = 8.0;

class ProfilePageUi extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfilePageUi(
      {Key? key, required this.visitedUserId, required this.currentUserId})
      : super(key: key);

  @override
  _ProfilePageUiState createState() => _ProfilePageUiState();
}

class _ProfilePageUiState extends State<ProfilePageUi> {
  late final _isOwnProfilePage = widget.visitedUserId == widget.currentUserId;

  List<Post> _allPosts = [];

  showProfilePosts(UserModel author) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _allPosts.length,
          itemBuilder: (context, index) {
            return PostContainer(
              post: _allPosts[index],
              author: author,
              currentUserId: widget.currentUserId,
            );
          }),
    );
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

  @override
  void initState() {
    super.initState();
    getAllPosts();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Authenticator().signOut();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          icon: Icon(Icons.logout),
          color: Colors.black,
        ),
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
          future: UserRepository.getUser(widget.currentUserId),
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
                    _isOwnProfilePage
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfileScreen(user: userModel),
                                ),
                              );
                              setState(() {});
                            },
                            child: Container(
                              width: 100,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                                border: Border.all(color: Colors.blue),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : Container()
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
