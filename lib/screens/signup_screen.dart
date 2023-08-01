import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwdController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUp(
      username: _userNameController.text,
      email: _emailController.text,
      password: _passwdController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res != "success") {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 255, 255, 255),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                cont: _userNameController,
                hintTxt: "enter Username ",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                cont: _emailController,
                hintTxt: "enter email ",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                cont: _passwdController,
                hintTxt: "enter password ",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                cont: _bioController,
                hintTxt: "enter Bio ",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: signUpUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor,
                        ),
                        child: const Text("SignUp"),
                      ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text("Already have an account ?  "),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: blueColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
