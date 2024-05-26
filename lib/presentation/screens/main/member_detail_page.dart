import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onboarding_app/presentation/widgets/services_card.dart';

class MemberDetailPage extends StatelessWidget {
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * .35,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(31, 65, 187, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              )
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape
                                  .circle, // Ensure the background is circular
                            ),
                            child: const Icon(
                              color: Color.fromRGBO(31, 65, 187, 1),
                              Icons.arrow_back,
                              size: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              "Member Detail",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape
                              .circle, // Ensure the background is circular
                        ),
                        child: const Icon(
                          color: Color.fromRGBO(31, 65, 187, 1),
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48),
                                child: const Image(
                                  image:
                                      AssetImage("assets/profile-image.jpeg"),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Leandro Trossard",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Nomor Induk: 10",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Text(
                                      //   "Indonesia - 0814123123",
                                      //   style: TextStyle(
                                      //     fontSize: 10,
                                      //     color: Colors.black,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 35),
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(31, 65, 187, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[400],
                          thickness: 1,
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green[200],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 30,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Saldo",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7),
                                          child: Text(
                                            "Rp 1.000.000",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                color: Colors.grey[400],
                                thickness: 1,
                                width: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellow[200],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.auto_graph_sharp,
                                      size: 30,
                                      color: Colors.yellow[700],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bunga",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7),
                                          child: Text(
                                            "3.5%",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                          child: LinearProgressIndicator(
                            value: 0.6,
                            minHeight: 6,
                            color: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, left: 5, right: 5, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Pay House rent - Reminder",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Jun 28, 2024",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Other Services",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ServicesCard(
                          icon: Icons.history,
                          label: "History",
                          onTap: () {},
                        ),
                        ServicesCard(
                          icon: Icons.savings_outlined,
                          label: "Setor",
                          onTap: () {},
                        ),
                        ServicesCard(
                          icon: Icons.attach_money,
                          label: "Tarik",
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
