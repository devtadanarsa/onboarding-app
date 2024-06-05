import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/date_input.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/form_header.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/text_input.dart';

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
    dobController = TextEditingController(text: widget.member.dateOfBirth);
    selectedDate = widget.member.dateOfBirth;

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
          buildHeader(context),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Column(
              children: [
                buildTextInput(
                    nameController, "Full Name", "John Marston", isNameValid),
                buildTextInput(nomorIndukController, "Nomor Induk", "100",
                    isNomorIndukValid),
                buildTextInput(
                    addressController, "Address", "Denpasar", isAddressValid),
                buildTextInput(phoneController, "Phone Number", "08123456789",
                    isPhoneValid),
                buildDateInput(
                    context, dobController, "Date of Birth", isDobValid,
                    (String date) {
                  setState(() {
                    selectedDate = date;
                  });
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

  void onSaveTap() {
    if (_allInputsValid()) {
      Member editedMember = Member(
        id: widget.member.id,
        nomorInduk: int.tryParse(nomorIndukController.text) ?? 0,
        name: nameController.text,
        address: addressController.text,
        dateOfBirth: selectedDate,
        phoneNumber: phoneController.text,
        isActive: 1,
      );
      BlocProvider.of<MemberBloc>(context)
          .add(EditMember(member: editedMember));
      Navigator.pop(context);
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
