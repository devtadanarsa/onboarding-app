import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding_app/bloc/bunga_bloc/bunga_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/bloc/user_bloc/user_bloc.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/team_member_card.dart';
import 'package:onboarding_app/presentation/screens/main/profile/pages/bunga_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserInitial) {
          BlocProvider.of<UserBloc>(context).add(LoadUser());
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (userState is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (userState is UserLoaded) {
          final user = userState.userInformation;
          return BlocBuilder<MemberBloc, MemberState>(
            builder: (context, memberState) {
              if (memberState is MemberLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (memberState is MemberInitial) {
                BlocProvider.of<MemberBloc>(context).add(LoadMember());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (memberState is MemberLoaded) {
                final members = memberState.members;
                return BlocBuilder<BungaBloc, BungaState>(
                  builder: (context, bungaState) {
                    if (bungaState is BungaInitial) {
                      BlocProvider.of<BungaBloc>(context).add(LoadBunga());
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (bungaState is BungaLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (bungaState is BungaLoaded) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/default-profile.png"),
                                      radius: 30,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Divider(),
                              ),
                              const HeadingText(
                                heading: "Team Members",
                                href: "See All Members",
                              ),
                              SizedBox(
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: List.generate(
                                      members.length > 3 ? 3 : members.length,
                                      (index) {
                                        return TeamMemberCard(
                                          id: members[index].id!,
                                          nomorInduk: members[index].nomorInduk,
                                          name: members[index].name,
                                          address: members[index].address,
                                          dateOfBirth:
                                              members[index].dateOfBirth,
                                          telephone: members[index].phoneNumber,
                                          isActive: members[index].isActive!,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Divider(),
                              ),
                              const HeadingText(
                                heading: "General Setting",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        "Setting Bunga",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        "${bungaState.activeBunga.persen}% (Saat ini)",
                                      ),
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_right_outlined)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        "Riwayat Bunga",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 120,
                                      child: Text(
                                        "Lihat Riwayat",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BungaPage(
                                              listBunga: bungaState.listBunga,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                          Icons.keyboard_arrow_right_outlined),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Divider(),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: LogoutButton(),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (bungaState is BungaError) {
                      return Center(
                        child: Text(bungaState.error),
                      );
                    } else {
                      return const Center(
                        child: Text("Unknown error pada Bunga"),
                      );
                    }
                  },
                );
              } else if (memberState is MemberError) {
                return Center(
                  child: Text(memberState.errorDescription),
                );
              } else {
                return Container(); // Handle other states if needed
              }
            },
          );
        } else if (userState is UserError) {
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
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/session-expired.jpg"),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Whoops, Your session has expired",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Your session has expired due to your inactivity. No worry, simply login again",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/");
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(); // Handle other states if needed
        }
      },
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
  const HeadingText({super.key, required this.heading, this.href});

  final String heading;
  final String? href;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
          if (href != null)
            Text(
              "All Members",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            )
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
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
