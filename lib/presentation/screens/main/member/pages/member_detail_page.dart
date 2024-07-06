import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onboarding_app/bloc/tabungan_bloc/tabungan_bloc.dart';
import 'package:onboarding_app/data/source/remote_source.dart';
import 'package:onboarding_app/presentation/screens/main/member/pages/transaction_history_page.dart';
import 'package:onboarding_app/presentation/widgets/custom_snackbar.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/services_card.dart';

class MemberDetailPage extends StatelessWidget {
  final int id;
  final int nomorInduk;
  final String name;
  final String address;
  final String dateOfBirth;
  final String telephone;

  const MemberDetailPage({
    super.key,
    required this.id,
    required this.nomorInduk,
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.telephone,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TabunganBloc(remoteDataSource: RemoteDataSource()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<TabunganBloc, TabunganState>(
          listener: (context, state) {
            if (state is TabunganAdded) {
              CustomSnackBar.show(
                  context, "success", "Transaksi Tabungan Berhasil!");
            } else if (state is TabunganError) {
              CustomSnackBar.show(context, "error", state.errorDescription);
            }
          },
          child: BlocBuilder<TabunganBloc, TabunganState>(
            builder: (context, state) {
              if (state is TabunganInitial || state is TabunganAdded) {
                BlocProvider.of<TabunganBloc>(context)
                    .add(LoadTabungan(memberId: id));
              }
              if (state is TabunganLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TabunganLoaded) {
                /**
                 * Main page starts here!
                 */
                return Stack(
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
                    ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /**
                               * Section : Page Header
                               */
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape
                                                .circle, // Ensure the background is circular
                                          ),
                                          child: const Icon(
                                            color:
                                                Color.fromRGBO(31, 65, 187, 1),
                                            Icons.arrow_back,
                                            size: 20,
                                          ),
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

                              /**
                               * Section : Profile Card
                               */
                              Container(
                                margin: const EdgeInsets.only(top: 25),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(48),
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Image(
                                                image: AssetImage(
                                                  "assets/unknown-profile.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Text(
                                                      name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Text(
                                                      "No Induk : $nomorInduk",
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 20,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.location_on,
                                                              size: 28,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 2),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    "Address",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    address,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .phone_android_outlined,
                                                                size: 28,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            2),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Phone",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      telephone,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // const Padding(
                                              //   padding:
                                              //       EdgeInsets.only(top: 20),
                                              //   child: Text(
                                              //     "Show Details",
                                              //     style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: Color.fromRGBO(
                                              //           31, 65, 187, 1),
                                              //       fontWeight: FontWeight.bold,
                                              //     ),
                                              //   ),
                                              // ),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green[200],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Icon(
                                                  Icons
                                                      .account_balance_wallet_outlined,
                                                  size: 30,
                                                  color: Colors.green[700],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Saldo",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7),
                                                      child: Text(
                                                        formatCurrency(
                                                            state.saldo),
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.yellow[200],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Icon(
                                                  Icons.connect_without_contact,
                                                  size: 30,
                                                  color: Colors.yellow[700],
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Status",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 7),
                                                      child: Text(
                                                        "Aktif",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                      padding: EdgeInsets.only(
                                          top: 15, left: 5, right: 5),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Pay House rent - Reminder",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
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

                              /**
                               * Section : Tabungan Service Options
                               */
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "Layanan Tabungan",
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
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TransactionHistoryPage(
                                              tabunganList: state.tabungan,
                                              saldoAkhir: state.saldo,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.history,
                                                size: 35,
                                                color: Color.fromRGBO(
                                                    31, 65, 187, 1),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              "Histori",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ServicesCard(
                                      memberId: id,
                                      idTransaksi: 2,
                                      saldo: state.saldo,
                                      icon: Icons.savings_outlined,
                                      label: "Simpan",
                                    ),
                                    ServicesCard(
                                      memberId: id,
                                      idTransaksi: 3,
                                      saldo: state.saldo,
                                      icon: Icons.call_received_rounded,
                                      label: "Tarik",
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ServicesCard(
                                      memberId: id,
                                      idTransaksi: 4,
                                      saldo: state.saldo,
                                      icon: Icons.query_stats_sharp,
                                      label: "Bunga",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 36),
                                      child: ServicesCard(
                                        memberId: id,
                                        saldo: state.saldo,
                                        idTransaksi: 1,
                                        icon: Icons.restart_alt,
                                        label: "Saldo Awal",
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
                                      "Koreksi Transaksi",
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
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ServicesCard(
                                      memberId: id,
                                      idTransaksi: 5,
                                      saldo: state.saldo,
                                      icon: Icons.addchart,
                                      label: "Tambah",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 36),
                                      child: ServicesCard(
                                        memberId: id,
                                        idTransaksi: 6,
                                        saldo: state.saldo,
                                        icon: Icons.delete_sweep_outlined,
                                        label: "Kurang",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is TabunganError) {
                BlocProvider.of<TabunganBloc>(context)
                    .add(LoadTabungan(memberId: id));
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  String formatCurrency(dynamic number) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return currencyFormat.format(number);
  }
}
