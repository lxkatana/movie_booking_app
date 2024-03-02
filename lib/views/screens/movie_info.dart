import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/home.dart';

class MovieInfo extends StatefulWidget {
  MovieInfo({Key? key}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(alignment: Alignment.topLeft,child: InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));} ,child: Icon(Icons.arrow_back, color: Colors.white, size: 32,))),
                    ),
                    height: 460,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/poster2.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 432,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 0, left: 24, right: 24),
                              child: Column(
                                children: [
                                  Container(
                                    // Rooms Details Container
                                    height: 240,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Breaking Bad",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    color: Colors.white),
                                              ),
                                              Spacer(),
                                              Container(
                                                height: 32,
                                                width: 60,
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        '4.5',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Ben Howling, Yolanda Ramke",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "A premium accommodation option typically larger and more elegantly appointed than standard rooms, deluxe rooms often feature upscale furnishings, amenities, and additional services. A premium accommodation option typically larger and more elegantly appointed than standard rooms, deluxe rooms often feature upscale furnishings, amenities, and additional services. A premium accommodation option typically larger and more elegantly appointed than standard rooms, deluxe rooms often feature upscale furnishings, amenities, and additional services. A premium accommodation option typically larger and more elegantly appointed than standard rooms, deluxe rooms often feature upscale furnishings, amenities, and additional services.",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Button for Book Now
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Book Ticket',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox( width: 8), 
                                            Icon(Icons.confirmation_number, color: Colors.white,), // Ticket icon
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
