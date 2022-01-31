import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({required this.weather});
  final Weather weather;


  @override
  State<WeatherScreen> createState() => _WeatherScreenState();

}


class _WeatherScreenState extends State<WeatherScreen> {


  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: new Color(0xffffffff),
                gradient: getGradientByMood(widget.weather)),
          ),
          Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 45.0)),
                  Image(
                    image: AssetImage('icons/${getIconByMood(widget.weather)}.png'),
                  ),
                  Padding(padding: EdgeInsets.only(top: 41.0)),
                  Text("${DateFormat.MMMMEEEEd('pl').format(DateTime.now())}, ${widget.weather.weatherDescription}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            height: 1.2,
                            color: Colors.white,
                          ))),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Text('${widget.weather.temperature!.celsius!.floor()}°C',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 64.0,
                            height: 1.2,
                            color: Colors.white,
                          ))),
                  Text('Odczuwalna ${widget.weather.tempFeelsLike!.celsius!.floor()} °C',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            height: 1.2,
                            color: Colors.white,
                          ))),
                  Padding(padding: EdgeInsets.only(bottom: 28.0)),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Ciśnienie',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16.0,
                                        height: 1.2,
                                        color: Colors.white,
                                      ))),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text('${widget.weather.pressure} hPa',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22.0,
                                        height: 1.2,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          width: 45,
                          thickness: 1,
                          color: Colors.white,
                        ),
                        Container(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Wiatr',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.0,
                                          height: 1.2,
                                          color: Colors.white,
                                        ))),
                                Padding(padding: EdgeInsets.only(top: 2.0)),
                                Text('${widget.weather.windSpeed} m/s',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22.0,
                                          height: 1.2,
                                          color: Colors.white,
                                        )))
                              ],
                            ))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 24.0)),
                  if(widget.weather.rainLastHour != null)
                  Text('Opady deszczu: ${widget.weather.rainLastHour}  mm/1h',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            height: 1.2,
                            color: Colors.white,
                          ))),
                    if(widget.weather.snowLastHour != null)
                    Text('Opady śniegu: ${widget.weather.snowLastHour}  mm/h',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              height: 1.2,
                              color: Colors.white,
                            ))),
                  Padding(padding: EdgeInsets.only(top: 68.0)),
                ],
              )),
        ]),
    );
  }

  String getIconByMood(Weather weather) {
    var main = weather.weatherMain;
    if(main == 'Dizzle'){
      return 'weather-rain';
    }else if(main == 'Clouds'){
      return 'weather-cloud';
    }else if(main == 'Snow'){
      return 'weather-snow';
    }else if(main == 'Thunderstorm'){
      return 'weather-lighting';
    }else if(isNight(weather)){
      return 'weather-moonny';
    }
    else{
      return 'weather-sunny';
    }
  }

  bool isNight(Weather weather) {
    var sunset = widget.weather.sunset;
    var sunrise = widget.weather.sunrise;
    return DateTime.now().isAfter(sunset!) || DateTime.now().isBefore(sunrise!);
  }

  LinearGradient getGradientByMood(Weather weather) {
    var main = weather.weatherMain;
    if(main == 'Clouds' || main == 'Dizzle' || main == 'Snow'){
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            new Color(0xff6E6CD8),
            new Color(0xff40A0EF),
            new Color(0xff77E1EE)
          ]);
    }else if(main == 'Thunderstorm'){
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            new Color(0xff313545),
            new Color(0xff121118),
          ]);
    }else if(isNight(weather)){
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            new Color(0xff313545),
            new Color(0xff121118),
          ]);
    }

    else{
      return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            new Color(0xffCDEDD4),
            new Color(0xff5283F0),
          ]);
    }
  }

}
