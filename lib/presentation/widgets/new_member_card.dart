import 'package:flutter/material.dart';

class NewMemberCard extends StatelessWidget {
  const NewMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: const Row(
        children: [
          CircleAvatar(
            minRadius: 30,
            backgroundImage: AssetImage("assets/default-profile.png"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Column(
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
