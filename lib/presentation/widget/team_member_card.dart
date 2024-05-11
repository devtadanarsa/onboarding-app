import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({
    super.key,
    required this.id,
    required this.nomorInduk,
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.telephone,
    required this.isActive,
  });

  final int id;
  final int nomorInduk;
  final String name;
  final String address;
  final String dateOfBirth;
  final String telephone;
  final int isActive;

  Future<bool> deleteMemberDialog(BuildContext context) async {
    bool deleteConfirmed = false;

    void onDeleteTap() {
      deleteConfirmed = true;
      BlocProvider.of<MemberBloc>(context).add(DeleteMember(memberId: id));
      BlocProvider.of<MemberBloc>(context).add(LoadMember());
      Navigator.pop(context);
    }

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                    color: Colors.red[100],
                  ),
                  child: const Icon(
                    Icons.warning_amber,
                    color: Colors.red,
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
                    "This action cannot be undone. All values associated with this member will be lost.",
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
                      onDeleteTap();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: const Text(
                      "Delete Member",
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
                      deleteConfirmed = false;
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

    return deleteConfirmed;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Dismissible(
        background: Container(
          color: Colors.red,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        key: ValueKey<int>(id),
        onDismissed: (DismissDirection direction) {},
        confirmDismiss: (direction) async {
          bool deleteConfirmed = await deleteMemberDialog(context);
          return deleteConfirmed;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/default-profile.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$nomorInduk - $address",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              EditMemberButton(
                id: id,
                nomorInduk: nomorInduk,
                name: name,
                address: address,
                dateOfBirth: dateOfBirth,
                telephone: telephone,
              )
            ],
          ),
        ),
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

class EditMemberButton extends StatelessWidget {
  const EditMemberButton({
    super.key,
    required this.id,
    required this.nomorInduk,
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.telephone,
  });

  final int id;
  final int nomorInduk;
  final String name;
  final String address;
  final String dateOfBirth;
  final String telephone;

  void editMemberDialog(BuildContext context) {
    final TextEditingController nomorIndukController =
        TextEditingController(text: nomorInduk.toString());
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController addressController =
        TextEditingController(text: address);
    final TextEditingController phoneController =
        TextEditingController(text: telephone);
    String selectedDate = dateOfBirth;

    bool areAnyFieldsEmpty() {
      final List<TextEditingController> controllers = [
        nomorIndukController,
        nameController,
        addressController,
        phoneController,
      ];

      return controllers.any((controller) => controller.text.isEmpty) ||
          selectedDate.isEmpty;
    }

    void editMember() {
      Member member = Member(
        id: id,
        nomorInduk: int.tryParse(nomorIndukController.text) ?? 0,
        name: nameController.text,
        address: addressController.text,
        dateOfBirth: selectedDate,
        phoneNumber: phoneController.text,
        isActive: 1,
      );

      BlocProvider.of<MemberBloc>(context).add(EditMember(member: member));
      BlocProvider.of<MemberBloc>(context).add(LoadMember());
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      builder: (context) {
        bool invalidInput = false;
        return StatefulBuilder(builder: (dialogContext, dialogSetState) {
          void onSaveTap() {
            if (areAnyFieldsEmpty()) {
              dialogSetState(() {
                invalidInput = true;
                Timer(const Duration(seconds: 3), () {
                  dialogSetState(() {
                    invalidInput = false;
                  });
                });
              });
            } else {
              editMember();
            }
          }

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
                      "Edit Team Member",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1F41BB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextInput(
                      hint: "Nomor Induk",
                      textController: nomorIndukController,
                    ),
                    TextInput(
                      hint: "Nama",
                      textController: nameController,
                    ),
                    TextInput(
                      hint: "Alamat",
                      textController: addressController,
                    ),
                    TextInput(
                      hint: "Telepon",
                      textController: phoneController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tanggal Lahir"),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? dateTime = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050),
                            );

                            if (dateTime != null) {
                              dialogSetState(() {
                                selectedDate = DateTime(dateTime.year,
                                        dateTime.month, dateTime.day)
                                    .toString();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Text(selectedDate.isEmpty
                              ? "Pick a Date"
                              : selectedDate.split(" ")[0]),
                        )
                      ],
                    ),
                    Visibility(
                      visible: invalidInput,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Center(
                          child: Text(
                            "Input is invalid!",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onSaveTap();
                      },
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
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editMemberDialog(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Icon(
              Icons.edit,
              size: 18,
              color: Color.fromRGBO(31, 65, 187, 1),
            ),
            Text(
              "Edit",
              style: TextStyle(
                color: Color.fromRGBO(31, 65, 187, 1),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
