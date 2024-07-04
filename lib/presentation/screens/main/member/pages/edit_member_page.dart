import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/date_input.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/form_header.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/text_input.dart';
import 'package:onboarding_app/utils/date_utils.dart';

class EditMemberPage extends StatefulWidget {
  const EditMemberPage({super.key, required this.member});
  final Member member;

  @override
  State<EditMemberPage> createState() => _EditMemberPageState();
}

class _EditMemberPageState extends State<EditMemberPage> {
  late TextEditingController nameController;
  late TextEditingController nomorIndukController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController dobController;

  String selectedDate = "";
  bool isInputValid = false;
  bool isActiveController = false;

  final ValueNotifier<bool> isNameValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isNomorIndukValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAddressValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPhoneValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isDobValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.member.name);
    nomorIndukController =
        TextEditingController(text: widget.member.nomorInduk.toString());
    addressController = TextEditingController(text: widget.member.address);
    phoneController = TextEditingController(text: widget.member.phoneNumber);
    dobController =
        TextEditingController(text: formatDate(widget.member.dateOfBirth));
    selectedDate = widget.member.dateOfBirth;
    isActiveController = widget.member.isActive == 1;

    isNameValid.value = nameController.text.isNotEmpty;
    isNomorIndukValid.value = nomorIndukController.text.isNotEmpty;
    isAddressValid.value = addressController.text.isNotEmpty;
    isPhoneValid.value = phoneController.text.isNotEmpty;
    isDobValid.value = dobController.text.isNotEmpty;
  }

  @override
  void dispose() {
    nameController.dispose();
    nomorIndukController.dispose();
    addressController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context, "Edit old member",
              "Organizing your members allows you to generate quotes faster and track them more efficiently."),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              children: [
                buildTextInput(nameController, "Full Name", "John Marston",
                    false, isNameValid),
                buildTextInput(nomorIndukController, "Nomor Induk", "100", true,
                    isNomorIndukValid),
                buildTextInput(addressController, "Address", "Denpasar", false,
                    isAddressValid),
                buildTextInput(phoneController, "Phone Number", "08123456789",
                    true, isPhoneValid),
                buildDateInput(
                    context, dobController, "Date of Birth", isDobValid,
                    (String date) {
                  setState(() {
                    selectedDate = date;
                  });
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Member Status : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        activeColor: const Color.fromRGBO(31, 65, 187, 1),
                        inactiveThumbColor:
                            const Color.fromRGBO(31, 65, 187, 1),
                        value: isActiveController,
                        onChanged: (bool value) {
                          setState(() {
                            isActiveController = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                      "Please fill all the fields",
                      style: TextStyle(
                        color: Colors.red,
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
    Member editedMember = Member(
      id: widget.member.id,
      nomorInduk: int.tryParse(nomorIndukController.text) ?? 0,
      name: nameController.text,
      address: addressController.text,
      dateOfBirth: selectedDate,
      phoneNumber: phoneController.text,
      isActive: isActiveController ? 1 : 0,
    );
    BlocProvider.of<MemberBloc>(context).add(EditMember(member: editedMember));
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
        isNomorIndukValid.value &&
        isAddressValid.value &&
        isPhoneValid.value &&
        isDobValid.value;
  }
}
