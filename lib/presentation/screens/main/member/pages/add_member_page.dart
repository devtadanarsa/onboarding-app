import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/date_input.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/form_header.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/text_input.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final nameController = TextEditingController();
  final nomorIndukController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  String selectedDate = "";
  bool isInputValid = false;

  final ValueNotifier<bool> isNameValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAddressValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPhoneValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isDobValid = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context, "Create new member",
              "Organizing your members allows you to generate quotes faster and track them more efficiently."),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              children: [
                buildTextInput(nameController, "Full Name", "John Marston",
                    false, isNameValid),
                buildTextInput(addressController, "Address", "Denpasar, Bali",
                    false, isAddressValid),
                buildTextInput(phoneController, "Phone Number", "081234567890",
                    true, isPhoneValid),
                buildDateInput(
                    context, dobController, "Date of Birth", isDobValid,
                    (String date) {
                  selectedDate = date;
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      onSaveTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        "Save Member",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isInputValid,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Your input is invalid!",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void saveMember() {
    int date = DateTime.now().millisecondsSinceEpoch;
    print(date);
    Member member = Member(
      nomorInduk: date,
      name: nameController.text,
      address: addressController.text,
      dateOfBirth: selectedDate,
      phoneNumber: phoneController.text,
    );
    BlocProvider.of<MemberBloc>(context).add(AddMember(member: member));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 300,
            width: 350,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue[100],
                  ),
                  child: const Icon(
                    Icons.warning_amber,
                    color: Color.fromRGBO(31, 65, 187, 1),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Are you sure?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Please make sure all of the fields are correct! This value will be inserted to our databases.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      saveMember();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(31, 65, 187, 1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: const Text(
                      "Save Member",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(color: Colors.grey)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSaveTap() {
    if (_allInputsValid()) {
      showConfirmationDialog();
    } else {
      setState(() {
        isInputValid = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            isInputValid = false;
          });
        });
      });
    }
  }

  bool _allInputsValid() {
    return isNameValid.value &&
        isAddressValid.value &&
        isPhoneValid.value &&
        isDobValid.value;
  }
}
