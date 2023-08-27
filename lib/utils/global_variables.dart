import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

int webScreenSize = 600;

final List<Widget> widgetOptions = <Widget>[
  FeedScreen(),
  SearchScreen(),
  const AddPost(),
  const Text("hai"),
];
