import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/presentation/widget/custom_snackbar.dart';
import 'package:onboarding_app/presentation/widget/team_member_card.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemberBloc, MemberState>(
      listener: (context, state) {
        if (state is MemberAdded) {
          CustomSnackBar.show(context, "success", "Member added successfully");
        } else if (state is MemberEdited) {
          CustomSnackBar.show(context, "success", "Member edited successfully");
        } else if (state is MemberDeleted) {
          CustomSnackBar.show(
              context, "success", "Member deleted successfully");
        } else if (state is MemberError) {
          CustomSnackBar.show(context, "error", state.errorDescription);
        }
      },
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, memberState) {
          if (memberState is MemberInitial ||
              memberState is MemberEdited ||
              memberState is MemberAdded ||
              memberState is MemberDeleted) {
            BlocProvider.of<MemberBloc>(context).add(LoadMember());
            return const Center(child: CircularProgressIndicator());
          } else if (memberState is MemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (memberState is MemberLoaded) {
            return _buildMemberList(memberState.members, context);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildMemberList(List<Member> members, BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            _buildHeader(),
            _buildSearchField(),
            _buildFiltersRow(),
            _buildMemberListHeader(),
            _buildMemberListContent(members),
          ],
        ),
        const AddMemberButton(),
      ],
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 25),
      child: Text(
        "Member List",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return const Padding(
      padding: EdgeInsets.only(top: 25),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1),
          hintText: "Search by name...",
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.mic_none_outlined),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(31, 65, 187, 1),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterButton("Filter"),
          _buildFilterButton("Sorts"),
          _buildFilterButton("Categories"),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(
          width: 2,
          color: const Color.fromRGBO(31, 65, 187, 1),
        ),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(31, 65, 187, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (text != "Filter") const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildMemberListHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 25),
      child: Text(
        "Member List",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMemberListContent(List<Member> members) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 90),
      child: SizedBox(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: List.generate(
              members.length,
              (index) => TeamMemberCard(
                id: members[index].id!,
                nomorInduk: members[index].nomorInduk,
                name: members[index].name,
                address: members[index].address,
                dateOfBirth: members[index].dateOfBirth,
                telephone: members[index].phoneNumber,
                isActive: members[index].isActive!,
              ),
            ),
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

class AddMemberButton extends StatelessWidget {
  const AddMemberButton({super.key});

  void addMemberDialog(BuildContext context) {
    final TextEditingController nomorIndukController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String selectedDate = "";

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

    void addMember() {
      Member member = Member(
        nomorInduk: int.tryParse(nomorIndukController.text) ?? 0,
        name: nameController.text,
        address: addressController.text,
        dateOfBirth: selectedDate,
        phoneNumber: phoneController.text,
      );

      BlocProvider.of<MemberBloc>(context).add(AddMember(member: member));
      Timer(const Duration(seconds: 1), () {
        BlocProvider.of<MemberBloc>(context).add(LoadMember());
      });
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
              addMember();
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
                      "New Team Member",
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
