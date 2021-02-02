import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:petface/main.dart';

class DogResultScreen extends StatefulWidget {
  final bool gender;
  final File imageFile1;
  final List output1;
  final bool loading1;
  DogResultScreen({
    this.gender,
    this.imageFile1,
    this.output1,
    this.loading1,
  });
  @override
  _DogResultScreenState createState() => _DogResultScreenState();
}

class _DogResultScreenState extends State<DogResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
        body: widget.output1 != null && widget.output1.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.1)
                      : Colors.blueGrey.withOpacity(0.3),
                ),
                child: SafeArea(
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.1)
                              : Colors.blueGrey.withOpacity(0.2),
                        ),
                        width: width * 1,
                        height: height * 0.08,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                '결과보기',
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
                                width: width * 0.1,
                              ),
                              Container(
                                width: width * 0.3,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: widget.gender
                                            ? Colors.pink.withOpacity(0.4)
                                            : Colors.blueGrey.withOpacity(0.7),
                                      ),
                                      Text(
                                        ' 홈으로 >',
                                        style: GoogleFonts.jua(
                                            color: widget.gender
                                                ? Colors.pink.withOpacity(0.4)
                                                : Colors.blueGrey
                                                    .withOpacity(0.7),
                                            fontSize: width * 0.036),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _calculation(context, widget.output1, widget.imageFile1,
                          widget.gender),
                    ],
                  )),
                ),
              )
            : Center(
                child: Container(
                    width: width * 0.5,
                    height: width * 0.5,
                    child: Column(
                      children: [
                        Text("Error"),
                        CircularProgressIndicator(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: widget.gender
                                ? Colors.pink.withOpacity(0.4)
                                : Colors.blueGrey.withOpacity(0.7),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            },
                            child: Text(
                              '홈으로',
                              style: GoogleFonts.jua(
                                  color: Colors.white, fontSize: width * 0.06),
                            ),
                          ),
                        ),
                      ],
                    ))));
  }

  Widget _calculation(
      BuildContext context, List output1, File image1, bool gender) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    double getNumber(double input, {int precision = 2}) => double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
    return Container(
      height: height * 0.8,
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "내 '아이'가 닮은 연예인은",
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                fontSize: width * 0.056,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "'${output1[0]['label']}'님 입니다.",
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: width * 0.056,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
              width: width * 0.6,
              height: width * 0.8,
              child: gender
                  ? FutureBuilder(
                      future: _getImage(context, "${output1[0]['label']}.png"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            child: snapshot.data,
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: width * 0.1,
                            height: width * 0.1,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    )
                  : FutureBuilder(
                      future: _getImage(context, "${output1[0]['label']}.PNG"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            child: snapshot.data,
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: width * 0.1,
                            height: width * 0.1,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    )),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "- 닮은 정도 -",
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                fontSize: width * 0.056,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          CircularPercentIndicator(
            radius: width * 0.4,
            lineWidth: width * 0.01,
            percent: getNumber(output1[0]['confidence']),
            center: new Text(
              getNumber(output1[0]['confidence'] * 100).toString() + "%",
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            progressColor: Colors.red,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width * 0.3,
                height: width * 0.4,
                child: Image.file(
                    File(
                      image1.path,
                    ),
                    fit: BoxFit.cover),
              ),
              Container(
                width: width * 0.3,
                height: width * 0.4,
                child: gender
                    ? FutureBuilder(
                        future:
                            _getImage(context, "${output1[0]['label']}.png"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: snapshot.data,
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: width * 0.1,
                              height: width * 0.1,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container();
                        },
                      )
                    : FutureBuilder(
                        future:
                            _getImage(context, "${output1[0]['label']}.PNG"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: snapshot.data,
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: width * 0.1,
                              height: width * 0.1,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container();
                        },
                      ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "약 " +
                getNumber(output1[0]['confidence'] * 100).toString() +
                "% 정도 닮았어요",
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                fontSize: width * 0.046,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "또 누굴 닮았을까?",
            style: GoogleFonts.jua(
              textStyle: TextStyle(
                fontSize: width * 0.056,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          output1.length >= 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: width * 0.4,
                      child: Column(
                        children: [
                          Container(
                              width: width * 0.3,
                              height: width * 0.4,
                              child: gender
                                  ? FutureBuilder(
                                      future: _getImage(context,
                                          "${output1[1]['label']}.png"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            child: snapshot.data,
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: width * 0.1,
                                            height: width * 0.1,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      },
                                    )
                                  : FutureBuilder(
                                      future: _getImage(context,
                                          "${output1[1]['label']}.PNG"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            child: snapshot.data,
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: width * 0.1,
                                            height: width * 0.1,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      },
                                    )),
                          Text(
                            output1[1]['label'],
                            style: GoogleFonts.jua(
                                textStyle: TextStyle(
                                    fontSize: width * 0.046,
                                    color: Colors.black)),
                          ),
                          Text(
                            getNumber(output1[1]['confidence'] * 100)
                                    .toString() +
                                "%",
                            style: GoogleFonts.jua(
                                textStyle: TextStyle(
                                    fontSize: width * 0.046,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    output1.length >= 3
                        ? Container(
                            width: width * 0.4,
                            child: Column(
                              children: [
                                Container(
                                    width: width * 0.3,
                                    height: width * 0.4,
                                    child: gender
                                        ? FutureBuilder(
                                            future: _getImage(context,
                                                "${output1[2]['label']}.png"),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return Container(
                                                  child: snapshot.data,
                                                );
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: width * 0.1,
                                                  height: width * 0.1,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return Container();
                                            },
                                          )
                                        : FutureBuilder(
                                            future: _getImage(context,
                                                "${output1[2]['label']}.PNG"),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return Container(
                                                  child: snapshot.data,
                                                );
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: width * 0.1,
                                                  height: width * 0.1,
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              return Container();
                                            },
                                          )),
                                Text(
                                  output1[2]['label'],
                                  style: GoogleFonts.jua(
                                      textStyle: TextStyle(
                                          fontSize: width * 0.046,
                                          color: Colors.black)),
                                ),
                                Text(
                                  getNumber(output1[2]['confidence'] * 100)
                                          .toString() +
                                      "%",
                                  style: GoogleFonts.jua(
                                      textStyle: TextStyle(
                                          fontSize: width * 0.046,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                )
              : Text(
                  "없습니다.:)",
                  style: GoogleFonts.jua(
                      textStyle: TextStyle(
                          fontSize: width * 0.046, color: Colors.black)),
                )
        ]),
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.cover,
      );
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
