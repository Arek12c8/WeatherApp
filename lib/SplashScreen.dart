import 'dart:developer';
import 'package:clean_air/MyHomePage.dart';
import 'package:clean_air/PermissionScreen.dart';
import 'package:clean_air/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                  colors: [new Color(0xff6671e5), new Color(0xff4852d9)])),
        ),
        Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('icons/cloud.png'),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(Strings.appTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.0,
                      color: Colors.white,
                    ))),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                Text('Aplikacja do monitorowania \n czystości powietrza',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ))),
              ],
            )),
        Positioned(
            left: 0,
            bottom: 35,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Text("Przywiewam dane...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0,
                    color: Colors.white,
                  ))),
            ))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PermissionScreen()));
  }else {
  SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
  executeOnceAfterBuild();
  });
  }
  }

  void executeOnceAfterBuild() async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
      forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 5))
      .then((value) => {loadLocationData(value)})
        .onError((error, stackTrace) => {
          Geolocator.getLastKnownPosition(forceAndroidLocationManager: true)
      .then((value) => {loadLocationData(value)})
    });



}

  loadLocationData(Position? value) async {

    var latitude = value!.latitude;
    var longitude = value.longitude;
    log(latitude.toString() + " " + longitude.toString());

    WeatherFactory wf = new WeatherFactory("238e1cf150cca96cf3b0203a7b759368",
        language: Language.POLISH);
    Weather w = await wf.currentWeatherByLocation(latitude, longitude);
    log(w.toJson().toString());





    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(weather: w)));

  }
  }
