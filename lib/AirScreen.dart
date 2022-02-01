import 'package:clean_air/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//todo This screen is still under development
class AirScreen extends StatefulWidget {
  @override
  State<AirScreen> createState() => _AirScreenState();
}

class _AirScreenState extends State<AirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: new Color(0xffffffff),
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    new Color(0xff34a4eb),
                    new Color(0xff34a4eb)])),
        ),
        Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('icons/cloud-sun.png'),
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(Strings.appTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.0,
                      color: Colors.black,
                    ))),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text('Tutaj w przyszłości będzie wyświetlana jakość powietrza ;)',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ))),
              ],
            )),
        // Positioned(
        //     left: 0,
        //     bottom: 35,
        //     right: 0,
        //     child: Container(
        //       alignment: Alignment.center,
        //       child: Text("Przywiewam dane...",
        //           textAlign: TextAlign.center,
        //           style: GoogleFonts.lato(
        //               textStyle: TextStyle(
        //             fontWeight: FontWeight.w300,
        //             fontSize: 18.0,
        //             color: Colors.black,
        //           ))),
        //     ))
      ]),
    );
  }

  bool havePermission() {
    return true;
  }
}
