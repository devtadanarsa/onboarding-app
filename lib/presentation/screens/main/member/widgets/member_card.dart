import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/data/model/member.dart';
import 'package:onboarding_app/presentation/screens/main/member/pages/edit_member_page.dart';
import 'package:onboarding_app/presentation/screens/main/member/pages/member_detail_page.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailPage(
                  id: id,
                  nomorInduk: nomorInduk,
                  name: name,
                  address: address,
                  dateOfBirth: dateOfBirth,
                  telephone: telephone),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        minRadius: 30,
                        backgroundImage:
                            AssetImage("assets/default-profile.png"),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(7.5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "No. Induk : $nomorInduk",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditMemberPage(
                          member: Member(
                            id: id,
                            nomorInduk: nomorInduk,
                            name: name,
                            address: address,
                            dateOfBirth: dateOfBirth,
                            phoneNumber: telephone,
                          ),
                        );
                      },
                    ),
                  );
                },
                child: const Column(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(31, 65, 187, 1),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> deleteMemberDialog(BuildContext context) async {
    bool deleteConfirmed = false;

    void onDeleteTap() {
      deleteConfirmed = true;
      BlocProvider.of<MemberBloc>(context).add(DeleteMember(memberId: id));
      Timer(const Duration(seconds: 1), () {
        BlocProvider.of<MemberBloc>(context).add(LoadMember());
      });
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
}
