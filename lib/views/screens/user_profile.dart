import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/home.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 85,
                      backgroundImage:
                          AssetImage("assets/images/poster3.jpeg"),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Rajesh Hamal",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "rajesh21@gmail.com",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("9806547332",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
              SizedBox(height: 28),
              Expanded(
                child: ListView(
                  children: [
                    buildListTile('Edit Profile', Icons.person, () {
                      // Add your onTap functionality here
                    }),
                    buildListTile('About us', Icons.question_mark, () {
                      // Add your onTap functionality here
                    }),
                    buildListTile('Help Center', Icons.bubble_chart, () {
                      // Add your onTap functionality here
                    }),
                    buildListTile('Logout', Icons.exit_to_app, () {
                      // Add your onTap functionality here
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, VoidCallback onTap) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 0.6,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Spacer(),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
