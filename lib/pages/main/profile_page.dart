import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding_app/data/source/remote_source.dart';
import 'package:onboarding_app/feature/user/bloc/user_bloc.dart';
import 'package:onboarding_app/util/team_member_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(remoteDataSource: RemoteDataSource())..add(LoadUser()),
      child: ListView(
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                final user = state.user;
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/default-profile.png"),
                            radius: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(
                              "Edit Profile Photo",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromRGBO(31, 65, 187, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const HeadingText(heading: "Profile Info"),
                    InformationField(
                      label: "Name",
                      value: user.name,
                    ),
                    InformationField(
                      label: "Email",
                      value: user.email,
                    ),
                  ],
                );
              } else if (state is UserError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Container();
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Divider(),
          ),
          const HeadingText(heading: "Team Members"),
          const TeamMemberCard(
            name: "Devta Danarsa",
            address: "Denpasar, Indonesia",
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Divider(),
          ),
          const LogoutButton(),
          const AddMemberButton(),
        ],
      ),
    );
  }
}

class InformationField extends StatelessWidget {
  const InformationField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              value,
            ),
          ),
          const Icon(Icons.keyboard_arrow_right_outlined)
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.info_outline,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hint,
    required this.textController,
  });

  final String hint;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(31, 65, 187, 1), width: 2),
        ),
      ),
    );
  }
}

class AddMemberButton extends StatelessWidget {
  const AddMemberButton({super.key});

  void addMemberDialog(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController telephoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 550,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 20,
                left: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "New Team Member",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1F41BB),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextInput(hint: "ID Number", textController: idController),
                  TextInput(hint: "Name", textController: nameController),
                  TextInput(hint: "Address", textController: addressController),
                  TextInput(
                      hint: "Telephone", textController: telephoneController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Date of Birth"),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2050),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: const Text("Pick a Date"),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      "Save Member",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(31, 65, 187, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          addMemberDialog(context);
        },
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final _localStorage = GetStorage();

  void onLogoutTap() async {
    try {
      final response = await Dio().get(
        "${LogoutButton._apiUrl}/logout",
        options: Options(headers: {
          'Authorization': "Bearer ${_localStorage.read("token")}"
        }),
      );

      if (response.statusCode != 200) {
        throw DioException.connectionTimeout;
      }
    } on DioException catch (e) {
      print("${e.response} - ${e.response?.statusCode}");
    } finally {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void logoutDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 250,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.warning_amber,
                          color: Color.fromRGBO(31, 65, 187, 1),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sign out from the App",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Are you sure you would like to sign out of your Account?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F41BB),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(145, 45),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onLogoutTap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          foregroundColor: const Color(0xFF1F41BB),
                          minimumSize: const Size(150, 45),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        logoutDialog();
      },
      child: const Text(
        "Log out",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
