import 'package:flutter/material.dart';
import 'package:onboarding_app/util/team_member_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Column(
            children: [
              CircleAvatar(
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Ubah Foto Profil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const HeadingText(heading: "Info Profil"),
        const InformationField(
          label: "Nama",
          value: "I Nengah Danarsa Suniadevta",
        ),
        const InformationField(
          label: "Email",
          value: "devtadanarsa@gmail.com",
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
