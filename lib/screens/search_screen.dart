import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isUsers = false;
  final TextEditingController cont = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: cont,
          decoration: const InputDecoration(labelText: "Serach for a user"),
          onFieldSubmitted: (String username) {
            setState(
              () {
                _isUsers = true;
              },
            );
          },
        ),
      ),
      body: _isUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .where(
                    "username",
                    isGreaterThanOrEqualTo: cont.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          (snapshot.data! as dynamic).docs[index]['photoUrl']),
                    ),
                    title: Text(
                        (snapshot.data! as dynamic).docs[index]["username"]),
                  ),
                  itemCount: (snapshot.data! as dynamic).docs.length,
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.doc("posts").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  itemBuilder: (context, index) => StaggeredGridTile.count(
                    crossAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    mainAxisCellCount: (index % 7 == 0) ? 2 : 1,
                    child: Image.network(
                        (snapshot.data! as dynamic).docs[index]["photoUrl"]),
                  ),
                );
              },
            ),
    );
  }
}
