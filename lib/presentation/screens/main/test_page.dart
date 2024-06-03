import 'package:flutter/material.dart';
import 'package:onboarding_app/presentation/widgets/new_member_card.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
          child: NewMemberCard(),
        ),
      ),
    );
  }
}
