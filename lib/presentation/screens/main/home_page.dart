import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/bloc/bunga_bloc/bunga_bloc.dart';
import 'package:onboarding_app/bloc/member_bloc/member_bloc.dart';
import 'package:onboarding_app/bloc/page_bloc/page_bloc.dart';
import 'package:onboarding_app/bloc/user_bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List promoImages = [
    "assets/promos/promo-1.jpg",
    "assets/promos/promo-2.jpg",
    "assets/promos/promo-3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<MemberBloc, MemberState>(
          builder: (context, memberState) {
            return BlocBuilder<BungaBloc, BungaState>(
              builder: (context, bungaState) {
                if (userState is UserLoaded &&
                    memberState is MemberLoaded &&
                    bungaState is BungaLoaded) {
                  return Stack(
                    children: [
                      const Image(
                        image: AssetImage("assets/city-bg.png"),
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        child: ListView(
                          /**
                           * Header
                           */
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Manager App",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(Icons.favorite_border),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                          Icons.headset_mic_outlined),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            /**
                    * Account Info (Blue Container)
                    */
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(31, 65, 187, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, ${userState.userInformation.name}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140,
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 15,
                                            bottom: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Members Count",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${memberState.members.length} Member",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_circle_right_sharp,
                                                        size: 15,
                                                        color: Color.fromRGBO(
                                                            31, 65, 187, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 140,
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 15,
                                            bottom: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Interest Rate",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${bungaState.activeBunga.persen}%",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_circle_right_sharp,
                                                        size: 15,
                                                        color: Color.fromRGBO(
                                                            31, 65, 187, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /**
                    * Please Complete Account Section
                    */
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Lets complete your account info!",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text(
                                          "And enjoy ThisApp more comfortably",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                        const Icon(Icons.navigate_next_rounded),
                                  )
                                ],
                              ),
                            ),

                            /**
                     * Service Section
                     */
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<PageBloc>(context)
                                          .add(SwitchPage(2));
                                    },
                                    child: const Column(
                                      children: [
                                        Icon(Icons.people_alt_outlined),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text(
                                            "Manage\nMember",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<PageBloc>(context)
                                          .add(SwitchPage(3));
                                    },
                                    child: const Column(
                                      children: [
                                        Icon(Icons.monetization_on_outlined),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text(
                                            "Interest\nRate",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<PageBloc>(context)
                                          .add(SwitchPage(3));
                                    },
                                    child: const Column(
                                      children: [
                                        Icon(Icons.memory_sharp),
                                        Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text(
                                            "Account\nSetting",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Column(
                                    children: [
                                      Icon(Icons.settings_outlined),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text(
                                          "See\nOthers",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /**
                     * Best Deal Section
                     */
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Best Deals",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "See All",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(31, 65, 187, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CarouselSlider(
                                items: [0, 1, 2].map((i) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Image(
                                      image: AssetImage(promoImages[i]),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    );
                                  });
                                }).toList(),
                                options: CarouselOptions(
                                  height: 170,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  if (memberState is MemberInitial) {
                    BlocProvider.of<MemberBloc>(context).add(LoadMember());
                  } else if (bungaState is BungaInitial) {
                    BlocProvider.of<BungaBloc>(context).add(LoadBunga());
                  } else if (userState is UserError) {
                    return Center(
                      child: Text(userState.error),
                    );
                  } else if (memberState is MemberError) {
                    return Center(
                      child: Text(memberState.errorDescription),
                    );
                  } else if (bungaState is BungaError) {
                    return Center(
                      child: Text(bungaState.errorDescription),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
