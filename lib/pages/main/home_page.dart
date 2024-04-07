import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/util/featured_card.dart';
import 'package:onboarding_app/util/recommendation_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List featuredList = [
    {
      "companyName": "Gojek",
      "companyLocation": "Jakarta",
      "jobTitle": "Software Engineer",
      "jobLocation": "Anywhere",
      "salary": "\$50K - \$60K",
      "imageUrl": "assets/companies/gojek-icon.png"
    },
    {
      "companyName": "Elux Space",
      "companyLocation": "Malang",
      "jobTitle": "UI/UX Designer",
      "jobLocation": "On-Site",
      "salary": "\$10K - \$30K",
      "imageUrl": "assets/companies/elux-icon.png"
    },
    {
      "companyName": "Djitugo",
      "companyLocation": "Denpasar",
      "jobTitle": "Web Developer",
      "jobLocation": "On-Site",
      "salary": "\$20K - \$30K",
      "imageUrl": "assets/companies/djitugo-icon.jpeg"
    },
  ];

  final List recommendationList = [
    {
      "companyName": "Tokopedia",
      "companyLocation": "Jakarta • Indonesia",
      "jobTitle": "Software Engineer",
      "jobLocation": "Onsite",
      "imageUrl": "assets/companies/tokopedia-icon.jpeg"
    },
    {
      "companyName": "Laksita Emi Saguna",
      "companyLocation": "Bali • Indonesia",
      "jobTitle": "Data Engineer",
      "jobLocation": "Onsite",
      "imageUrl": "assets/companies/laksita-icon.png"
    },
    {
      "companyName": "eFishery Indonesia",
      "companyLocation": "Bandung • Indonesia",
      "jobTitle": "Graphic Designer",
      "jobLocation": "Onsite",
      "imageUrl": "assets/companies/efishery-icon.png"
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
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color.fromRGBO(31, 65, 187, 1),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/profile-image.jpeg"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Devta Danarsa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.notifications_none_outlined,
              size: 30,
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text("Hello Devta!"),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "Find Your Dream Job 🙌🏻",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(31, 65, 187, 1),
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search your dream job",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(31, 65, 187, 1),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(31, 65, 187, 1),
                ),
                child: const Icon(
                  Icons.tune,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Featured Jobs",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Color.fromRGBO(31, 65, 187, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: (index == 0 ? 0 : 10)),
                  child: FeaturedCard(
                    companyName: featuredList[index]["companyName"],
                    companyLocation: featuredList[index]["companyLocation"],
                    jobTitle: featuredList[index]["jobTitle"],
                    jobLocation: featuredList[index]["jobLocation"],
                    salary: featuredList[index]["salary"],
                    imageUrl: featuredList[index]["imageUrl"],
                  ),
                );
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recommendation",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Color.fromRGBO(31, 65, 187, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: SizedBox(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: List.generate(recommendationList.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(top: (index == 0 ? 0 : 10)),
                    child: RecommendationCard(
                      companyName: recommendationList[index]["companyName"],
                      companyLocation: recommendationList[index]
                          ["companyLocation"],
                      jobTitle: recommendationList[index]["jobTitle"],
                      jobLocation: recommendationList[index]["jobLocation"],
                      imageUrl: recommendationList[index]["imageUrl"],
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
