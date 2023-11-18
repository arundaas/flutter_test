import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1 extends StatefulWidget {
  @override
  _Lesson1State createState() => _Lesson1State();
}

class _Lesson1State extends State<Lesson1> {
  String titleText = 'Youtube Premium';
  String image = 'assets/images/youtube-red.png';

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
                  backgroundImage: AssetImage(image),
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
                        print("here");
                        titleText = titleText == 'Youtube Premium'
                            ? 'My Premium'
                            : 'Youtube Premium';
                        image = image == 'assets/images/youtube-red.png'
                            ? 'assets/images/youtube-green.png'
                            : 'assets/images/youtube-red.png';
                      });
                    },
                    leading: Icon(Icons.chat, size: 35, color: Colors.white),
                    title: Text(
                      'contact@youtube.com',
                      style: GoogleFonts.teko(
                        textStyle: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    trailing: Text(
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
