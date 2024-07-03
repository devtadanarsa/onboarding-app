import 'package:flutter/material.dart';
import 'package:onboarding_app/data/model/bunga.dart';

class BungaCard extends StatelessWidget {
  const BungaCard({
    super.key,
    required this.bungaInformation,
  });

  final Bunga bungaInformation;

  @override
  Widget build(BuildContext context) {
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
              Icon(
                bungaInformation.isActive == 0
                    ? Icons.indeterminate_check_box
                    : Icons.check_box,
                color:
                    bungaInformation.isActive == 0 ? Colors.grey : Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: SizedBox(
                  width: 50,
                  child: Text(
                    "${bungaInformation.persen.toString()}%",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Persentase Bunga",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   bungaInformation.isActive == 0 ? "Tidak Aktif" : "Aktif",
                  //   style: const TextStyle(fontSize: 10, color: Colors.grey),
                  // )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: bungaInformation.isActive == 1
                  ? Colors.green[100]
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              bungaInformation.isActive == 1 ? "Bunga Aktif" : "Non-Aktif",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
