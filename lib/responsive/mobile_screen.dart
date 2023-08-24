import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as model;
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  // String username = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  // }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)["username"];
  //   });
  // }

  // late PageController pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   pageController = PageController();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   pageController.dispose();
  // }

  // void navigationTapped(double page) {
  //   pageController.jumpTo(page);
  // }

  // int _page = 0;
  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void navTapped(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: mobileBackgroundColor,
        currentIndex: _selectedIndex,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 25),
        showSelectedLabels: false,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        showUnselectedLabels: false,
        unselectedItemColor: const Color.fromARGB(255, 144, 143, 143),
        onTap: navTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: " ",
            backgroundColor: primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: " ",
            backgroundColor: primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: " ",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: (_selectedIndex == 3)
                ? const Icon(Icons.favorite_rounded)
                : const Icon(Icons.favorite_outline_rounded),
            label: " ",
            backgroundColor: primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: " ",
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
