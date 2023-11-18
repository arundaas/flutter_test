import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String titleText = 'Youtube Premium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        color: Color.fromARGB(255, 39, 49, 38),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 75.0,
                  backgroundColor: Colors.red,
                  backgroundImage: AssetImage('assets/images/youtubeLogo.jpg'),
                ),
                Text(
                  titleText,
                  style: TextStyle(
                    fontFamily: 'Yellowtail',
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Watch videos unlimited.',
                  style: TextStyle(
                    fontFamily: 'Big Shoulders Display',
                    fontSize: 35,
                    color: Colors.white70,
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(30),
                  color: Colors.red[900],
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        titleText = 'Mytube Premium';
                      });
                    },
                    leading: Icon(Icons.chat, size: 35, color: Colors.white),
                    title: Text(
                      'contact@youtube.com',
                      style: GoogleFonts.teko(
                        textStyle: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 33.0),
                  color: Colors.red[900],
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        titleText = 'Youtube Premium';
                      });
                    },
                    leading:
                        Icon(Icons.call_made, size: 35, color: Colors.white),
                    title: Text(
                      ' +1 650-253-0001',
                      style: GoogleFonts.teko(
                        textStyle: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
