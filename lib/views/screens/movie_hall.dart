import 'package:flutter/material.dart';

class MovieHall extends StatefulWidget {
  MovieHall({Key? key}) : super(key: key);

  @override
  State<MovieHall> createState() => _MovieHallState();
}

class _MovieHallState extends State<MovieHall> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade900,
            shadowColor: Colors.black87,
            elevation: 5,
            leading: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 25),
              height: 240,
              width: double.infinity,
              color: Colors.deepPurple.shade900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              8), // Same as ClipRRect's borderRadius
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.white.withOpacity(0.1), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: Offset(0, 3), // Shadow offset
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/images/poster2.jpeg",
                            height: 200,
                            width: 165,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Breaking Bad",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white)),
                              Text("Max Bellchrome",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: Colors.white)),
                              Text("180 min",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.white)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade900,
                        border: Border(
                          top: BorderSide(
                            color: Colors.white,
                            width: 0.4,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/img1.jpeg',
                                    height: 82,
                                    width: 82,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'QFX Cinema Hall',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            "10:30",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        SizedBox(width: 12,),
                                        Container(
                                          height: 45,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            "10:30",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        Container(
                                          height: 45,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            "10:30",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        Container(
                                          height: 45,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            "10:30",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        Container(
                                          height: 45,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                            "10:30",
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
