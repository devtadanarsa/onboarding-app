import 'package:flutter/material.dart';
import 'package:onboarding_app/data/model/bunga.dart';
import 'package:onboarding_app/presentation/screens/main/profile/widgets/bunga_card.dart';

class BungaPage extends StatelessWidget {
  const BungaPage({
    super.key,
    required this.listBunga,
  });

  final List<Bunga> listBunga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(31, 65, 187, 1),
            pinned: true,
            expandedHeight: 0.0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(31, 65, 187, 1),
                        size: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Text(
                      "Interest History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          listBunga.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: (index == 0) ? 20 : 0),
                        child: BungaCard(bungaInformation: listBunga[index]),
                      );
                    },
                    childCount: listBunga.length,
                  ),
                )
              : const SliverFillRemaining(
                  child: Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Text(
                      "There is no Bunga History!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
