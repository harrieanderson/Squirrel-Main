import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:squirrel/models/repo.dart';
import 'package:squirrel/models/usser_model.dart';
import 'package:squirrel/src/screens/add_post_screen.dart';
import 'package:squirrel/src/screens/search_screen.dart';
import 'package:squirrel/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData = {};

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = snap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    currentUserId: widget.uid,
                  ),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FutureBuilder<UserModel>(
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
                      ],
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPostScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      ),
                    );
                  },
                  child: Text(' Make a post'),
                ),
              ],
            ),
          ),
          Divider(
            indent: 0.0,
            endIndent: 0.0,
            thickness: 10,
          ),
        ],
      ),
    );
  }
}
