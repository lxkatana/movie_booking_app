import 'package:flutter/material.dart';
import 'package:movie_booking/views/credentials/login.dart';
import 'package:movie_booking/views/screens/changePassword.dart';
import 'package:movie_booking/views/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name = '';
  String? gmail = '';

  @override
  void initState() {
    super.initState();
    fetchDataFromSharedPreferences();
  }

  Future<void> fetchDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
      gmail = prefs.getString('gmail');
    });
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      backgroundImage: NetworkImage(
                          "https://imgs.search.brave.com/yWXWHBTAAnm3pQof7RJ3JtjAxMGg2QF5h6wFelNYJSU/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMua29udGVudC5h/aS80ZWMyNjJhNy0z/ZDZjLTAwOGMtYWEx/MC0xZTZmZmM2YzJl/MTQvYjJjNWEzNmIt/NjZhYy00NWZmLTkw/MmUtNjNkMTJiZWYz/ZDY2L2Nsb3VkaW5h/cnlfaW50ZWdyYXRp/b24ucG5nP3c9ODAw/JnE9NzUmbG9zc2xl/c3M9ZmFsc2UmYXV0/bz1mb3JtYXQ"),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    _name ?? '',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    gmail ?? '',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Expanded(
                child: ListView(
                  children: [
                    buildListTile('Change Password', Icons.key, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordPage()));
                    }),
                    buildListTile('Logout', Icons.exit_to_app, () {
                      clearSharedPreferences();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Spacer(),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
