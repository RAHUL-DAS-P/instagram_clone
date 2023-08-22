import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

int webScreenSize = 600;

final List<Widget> widgetOptions = <Widget>[
  FeedScreen(),
  const Text("Ticket"),
  const AddPost(),
  const Text("hai"),
];
