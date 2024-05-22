import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/user_bloc/user_bloc.dart';
import 'package:onboarding_app/presentation/screens/main/home_page.dart';
import 'package:onboarding_app/presentation/screens/main/member_page.dart';
import 'package:onboarding_app/presentation/screens/main/profile_page.dart';
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
    const UnfinishedPage(),
    const MemberPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: _buildBottomAppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserInitial) {
            BlocProvider.of<UserBloc>(context).add(LoadUser());
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserLoaded) {
            return _buildPageContent();
          } else if (userState is ExpiredToken) {
            return _buildExpiredTokenDialog(context);
          } else if (userState is UserError) {
            return _buildErrorDialog(context);
          } else {
            return Container(); // Handle other states if needed
          }
        },
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey, blurRadius: 10, blurStyle: BlurStyle.inner)
        ],
      ),
      child: BottomAppBar(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomNavigationBarItem(
                  0, Icons.home_work_outlined, "Home"),
              _buildBottomNavigationBarItem(1, Icons.search, "Search"),
              _buildBottomNavigationBarItem(
                  2, Icons.theater_comedy_outlined, "Member"),
              _buildBottomNavigationBarItem(
                  3, Icons.person_outline_sharp, "Account"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(int index, IconData icon, String label) {
    final isSelected = _selectedIdx == index;
    final color =
        isSelected ? const Color.fromRGBO(31, 65, 187, 1) : Colors.black;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIdx = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: _pages[_selectedIdx],
    );
  }

  Widget _buildExpiredTokenDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 420,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/session-expired.jpg")),
              const SizedBox(height: 20),
              const Text(
                "Whoops, Your session has expired",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Your session has expired due to your inactivity. No worry, simply login again",
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 420,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/error.jpg")),
              const SizedBox(height: 20),
              const Text(
                "Whoops, Something went wrong",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "We're sorry, something went wrong. Please try again later",
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(LoadUser());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F41BB),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
