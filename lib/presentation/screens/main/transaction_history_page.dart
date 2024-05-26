import 'package:flutter/material.dart';
import 'package:onboarding_app/data/model/tabungan.dart';
import 'package:onboarding_app/presentation/widgets/transaction_card.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<Tabungan> tabunganList;
  const TransactionHistoryPage({super.key, required this.tabunganList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 20,
                left: 15,
                right: 15,
              ),
              color: const Color.fromRGBO(31, 65, 187, 1),
              child: Row(
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
                        color: Color.fromRGBO(31, 65, 187, 1),
                        Icons.arrow_back,
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: List.generate(tabunganList.length, (index) {
                      return TransactionCard(
                          transactionId: tabunganList[index].idTransaksi,
                          date: tabunganList[index].tanggal,
                          amount: tabunganList[index].nominalTransaksi);
                    }),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
