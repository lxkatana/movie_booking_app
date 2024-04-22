import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/user_profile.dart';

class AboutusPage extends StatelessWidget {
  AboutusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 65.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "About us",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 12,
              ),
              Image.asset("assets/images/aboutUs.png", height: 320, width: 320,),
              SizedBox(
                height: 8,
              ),
              Text(
                "Our Mission",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Our mission is simply to provide you with the best possible movie-watching experience. We strive to curate a diverse selection of films, ranging from the latest blockbusters to timeless classics, ensuring that there's something for everyone to enjoy.",
                textAlign: TextAlign.justify, // Align text to justify
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Stay Updated",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Stay updated with the latest news, reviews, and industry insights with our comprehensive collection of articles, blog posts, and editorial features. From behind-the-scenes glimpses to in-depth analyses, we're your go-to source for all things movie-related.",
                textAlign: TextAlign.justify, // Align text to justify
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Thank you !!!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
