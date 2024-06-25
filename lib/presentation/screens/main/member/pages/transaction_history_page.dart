import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onboarding_app/data/model/tabungan.dart';
import 'package:onboarding_app/presentation/screens/main/member/widgets/transaction_card.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<Tabungan> tabunganList;
  final int saldoAkhir;

  const TransactionHistoryPage({
    super.key,
    required this.tabunganList,
    required this.saldoAkhir,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(31, 65, 187, 1),
        padding: const EdgeInsets.all(0),
        elevation: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rekap Tabungan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Saldo Akhir",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatCurrency(saldoAkhir),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                      "Transaction History",
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(top: (index == 0) ? 20 : 0),
                  child: TransactionCard(
                    transactionId: tabunganList[index].idTransaksi,
                    date: tabunganList[index].tanggal,
                    amount: tabunganList[index].nominalTransaksi,
                  ),
                );
              },
              childCount: tabunganList.length,
            ),
          ),
        ],
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
