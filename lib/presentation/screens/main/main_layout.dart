import 'package:flutter/material.dart';
import 'package:onboarding_app/presentation/screens/main/home_page.dart';
import 'package:onboarding_app/presentation/screens/main/profile_page.dart';
import 'package:onboarding_app/presentation/screens/main/search_page.dart';
import 'package:onboarding_app/presentation/screens/main/unfinished_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIdx = 0;

  final List _pages = [
    HomePage(),
    SearchPage(),
    const UnfinishedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              blurStyle: BlurStyle.inner,
            )
          ],
        ),
        child: BottomAppBar(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIdx = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_work_outlined,
                        color: (_selectedIdx == 0
                            ? const Color.fromRGBO(31, 65, 187, 1)
                            : Colors.black),
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_selectedIdx == 0
                              ? const Color.fromRGBO(31, 65, 187, 1)
                              : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIdx = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: (_selectedIdx == 1
                            ? const Color.fromRGBO(31, 65, 187, 1)
                            : Colors.black),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_selectedIdx == 1
                              ? const Color.fromRGBO(31, 65, 187, 1)
                              : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIdx = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: (_selectedIdx == 2
                            ? const Color.fromRGBO(31, 65, 187, 1)
                            : Colors.black),
                      ),
                      Text(
                        "Messages",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_selectedIdx == 2
                              ? const Color.fromRGBO(31, 65, 187, 1)
                              : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIdx = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline_sharp,
                        color: (_selectedIdx == 3
                            ? const Color.fromRGBO(31, 65, 187, 1)
                            : Colors.black),
                      ),
                      Text(
                        "Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_selectedIdx == 3
                              ? const Color.fromRGBO(31, 65, 187, 1)
                              : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
        child: _pages[_selectedIdx],
      ),
    );
  }
}
