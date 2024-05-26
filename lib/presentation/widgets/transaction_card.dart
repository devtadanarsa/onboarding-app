import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final int transactionId;
  final String date;
  final int amount;

  const TransactionCard({
    super.key,
    required this.transactionId,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    String transactionLabel = "Transaksi";
    switch (transactionId) {
      case 1:
        transactionLabel = "Saldo Awal";
        break;
      case 2:
        transactionLabel = "Trans. Simpanan";
        break;
      case 3:
        transactionLabel = "Trans. Penarikan";
        break;
      case 4:
        transactionLabel = "Bunga Simpanan";
        break;
      case 5:
        transactionLabel = "Koreksi Penambahan";
        break;
      case 6:
        transactionLabel = "Koreksi Pengurangan";
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.monetization_on,
                size: 40,
                color: Color.fromRGBO(31, 65, 187, 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "July 30, 2024",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${(transactionId == 3 || transactionId == 6) ? "-" : "+"} Rp ${amount.toString()}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Success",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
