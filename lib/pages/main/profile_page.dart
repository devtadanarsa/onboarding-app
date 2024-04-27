import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboarding_app/util/team_member_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";
  final _localStorage = GetStorage();
  var userData;

  void addMemberDialog(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController telephoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
              bottom: 20,
            ),
            child: SizedBox(
              height: 550,
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

  void getUserData() async {
    try {
      var response = await Dio().get("$_apiUrl/user",
          options: Options(headers: {
            'Authorization': "Bearer ${_localStorage.read("token")}"
          }));

      if (response.statusCode == 200) {
        setState(() {
          userData = response.data["data"]["user"];
        });
      } else {
        throw DioException.connectionTimeout;
      }
    } on DioException catch (e) {
      print("Error ${e.response?.statusCode} - ${e.response?.data}");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/default-profile.png"),
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
            const HeadingText(heading: "Info Profil"),
            InformationField(
              label: "Name",
              value: (userData != null ? userData["name"] : "Loading..."),
            ),
            InformationField(
              label: "Email",
              value: (userData != null ? userData["email"] : "Loading..."),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Divider(),
            ),
            const HeadingText(heading: "List Anggota Tim"),
            const TeamMemberCard(
              name: "Devta Danarsa",
              address: "Badung, Indonesia",
            ),
          ],
        ),
        Container(
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
        ),
      ],
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
