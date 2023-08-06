import 'dart:typed_data';
import 'package:instagram_clone/responsive/firestore_methods.dart';

import '../models/user.dart' as model;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  bool _isLoading = false;

  final TextEditingController _descriptionController = TextEditingController();

  void clearFile() {
    setState(() {
      _file = null;
    });
  }

  void postImage(String uid, String profImage, String username) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadImage(
          username, _descriptionController.text, _file!, uid, profImage);
      if (res == "Success") {
        showSnackBar("Success", context);
        setState(() {
          _isLoading = false;
        });
        clearFile();
      } else {
        showSnackBar(res, context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _selectImage() async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: _selectImage,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: const IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: null,
              ),
              title: const Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.photoUrl, user.username),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator(
                        color: Colors.blueAccent,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(
                          top: 0,
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        user.photoUrl,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          hintText: "Write a caption ",
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 487,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!),
                              colorFilter:
                                  const ColorFilter.linearToSrgbGamma(),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
              ],
            ),
          );
  }
}
