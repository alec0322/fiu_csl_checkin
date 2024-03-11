// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List imgSrc = [
    "assets/download.png",
    "assets/download1.png",
    "assets/download1.png",
    "assets/download.png",
  ];

    List titles = [
    "My Devices",
    "Check-out",
    "TBA",
    "TBA",
  ];
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 7, 37, 61),
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/fiu_roary.png",
                        ))),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Last Update: 8 March 2024",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              height: height * 0.57,
              width: width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: imgSrc.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imgSrc[index],
                            width: 100,
                          ),
                          Text(
                            titles[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                    ),
                    ),
              );
                },
              ),
        ),
        const SizedBox(height: 20),
        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.add_circled),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black
              ),
              label:const Text('Scan Item'),
            ),
          ],
        ),
          ],
    ),
      ),
    );
  }
}
