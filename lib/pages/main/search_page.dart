import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Bali, Indonesia",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Edit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 65, 187, 1),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(1),
              hintText: "Search by job title...",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.mic_none_outlined),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(31, 65, 187, 1),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    width: 2,
                    color: const Color.fromRGBO(31, 65, 187, 1),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.tune,
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(31, 65, 187, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    width: 2,
                    color: const Color.fromRGBO(31, 65, 187, 1),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Sorts",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(31, 65, 187, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    width: 2,
                    color: const Color.fromRGBO(31, 65, 187, 1),
                  ),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(31, 65, 187, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
