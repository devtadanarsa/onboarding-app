import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard(
      {super.key, required this.id, required this.name, required this.address});

  final int id;
  final String name;
  final String address;

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
                          address,
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
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 6,
                  bottom: 6,
                ),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
