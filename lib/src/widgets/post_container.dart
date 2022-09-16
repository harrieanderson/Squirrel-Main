// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:squirrel_main/models/post.dart';
import 'package:squirrel_main/models/user.dart';

class PostContainer extends StatefulWidget {
  final Post post;
  final UserModel author;
  final String currentUserId;
  const PostContainer(
      {Key? key,
      required this.post,
      required this.author,
      required this.currentUserId})
      : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.author.photoUrl,
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.author.username,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Text(
                      '  ' +
                          widget.post.timestamp
                              .toDate()
                              .toString()
                              .substring(0, 16),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.post.text,
          ),
          widget.post.image.isEmpty
              ? SizedBox.shrink()
              : Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.post.image),
                        ),
                      ),
                    )
                  ],
                ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.thumb_up),
                  ),
                  Text(
                    '${widget.post.likes} likes',
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.comment),
                  ),
                  Text(
                    '${widget.post.likes} comments',
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
