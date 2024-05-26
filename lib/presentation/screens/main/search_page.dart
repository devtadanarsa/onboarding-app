import 'package:flutter/material.dart';
import 'package:onboarding_app/presentation/widgets/suggested_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final List suggestedList = [
    {
      "companyName": "Gojek",
      "companyLocation": "Jakarta",
      "jobTitle": "Software Engineer",
      "jobLocation": "Anywhere",
      "salary": "50K - 60K",
      "imageUrl": "assets/companies/gojek-icon.png",
      "isFastApply": true,
      "dayPosted": 1,
    },
    {
      "companyName": "Gojek",
      "companyLocation": "Jakarta",
      "jobTitle": "Product Designer",
      "jobLocation": "On-Site",
      "salary": "10K - 30K",
      "imageUrl": "assets/companies/gojek-icon.png",
      "isFastApply": true,
      "dayPosted": 1,
    },
    {
      "companyName": "Gojek",
      "companyLocation": "Jakarta",
      "jobTitle": "Tech Researcher",
      "jobLocation": "On-Site",
      "salary": "100K - 130K",
      "imageUrl": "assets/companies/gojek-icon.png",
      "isFastApply": false,
      "dayPosted": 2,
    },
    {
      "companyName": "Elux Space",
      "companyLocation": "Bandung",
      "jobTitle": "Graphic Designer",
      "jobLocation": "Remote",
      "salary": "5K - 10K",
      "imageUrl": "assets/companies/elux-icon.png",
      "isFastApply": true,
      "dayPosted": 5,
    },
    {
      "companyName": "Djitugo",
      "companyLocation": "Bali",
      "jobTitle": "Web Developer",
      "jobLocation": "On-Site",
      "salary": "10K - 13K",
      "imageUrl": "assets/companies/djitugo-icon.jpeg",
      "isFastApply": true,
      "dayPosted": 5,
    },
  ];

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
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            "Suggested Job",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: List.generate(suggestedList.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(top: (index == 0 ? 0 : 10)),
                    child: SuggestedCard(
                      companyName: suggestedList[index]["companyName"],
                      companyLocation: suggestedList[index]["companyLocation"],
                      jobTitle: suggestedList[index]["jobTitle"],
                      jobLocation: suggestedList[index]["jobLocation"],
                      salary: suggestedList[index]["salary"],
                      imageUrl: suggestedList[index]["imageUrl"],
                      isFastApply: suggestedList[index]["isFastApply"],
                      dayPosted: suggestedList[index]["dayPosted"],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
