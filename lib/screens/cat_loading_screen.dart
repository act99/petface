import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:petface/screens/cat_result_screen.dart';

class CatLoadingScreen extends StatefulWidget {
  final bool gender;
  final File imageFile1;
  final List output1;
  final bool loading1;
  CatLoadingScreen({this.gender, this.imageFile1, this.output1, this.loading1});
  @override
  _CatLoadingScreenState createState() => _CatLoadingScreenState();
}

class _CatLoadingScreenState extends State<CatLoadingScreen> {
  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  startTimer() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CatResultScreen(
                  gender: widget.gender,
                  imageFile1: widget.imageFile1,
                  output1: widget.output1,
                  loading1: widget.loading1,
                )));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: widget.gender ? Color(0xfffde8ef) : Color(0xffeef2f3),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.15,
                ),
                Image.asset(
                  'assets/loading.gif',
                  width: width * 0.6,
                  height: width * 0.6,
                ),
                Text(
                  '사진 분석 중 입니다.',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: width * 0.056,
                      color: widget.gender
                          ? Colors.pink.withOpacity(0.3)
                          : Colors.blueGrey.withOpacity(0.7),
                    ),
                  ),
                ),
                Text(
                  '잠시만 기다려주세요.',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: width * 0.056,
                      color: widget.gender
                          ? Colors.pink.withOpacity(0.3)
                          : Colors.blueGrey.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: width * 0.06,
                    animationDuration: 4000,
                    percent: 1,
                    center: Text(
                      '로딩중...',
                      style: GoogleFonts.jua(
                        textStyle: TextStyle(
                          fontSize: width * 0.048,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                        ),
                      ),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor:
                        widget.gender ? Colors.pink[100] : Colors.blueGrey[100],
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
