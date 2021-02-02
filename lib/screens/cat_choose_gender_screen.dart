import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petface/screens/cat_choose_screen.dart';
import 'package:petface/widget/rolling_switch.dart';

class CatChooseGenderScreen extends StatefulWidget {
  @override
  _CatChooseGenderScreenState createState() => _CatChooseGenderScreenState();
}

class _CatChooseGenderScreenState extends State<CatChooseGenderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // pageview

  bool gender;

  @override
  void initState() {
    super.initState();

    gender = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffd5fb),
        foregroundColor: Color(0xffffd5fb),
        shadowColor: Color(0xffffd5fb),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: Color(0xffffd5fb)),
                width: width * 1,
                height: height * 0.7,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: height * 0.07),
                      child: Text(
                        '아기의 성별을 골라주세요.',
                        style: GoogleFonts.jua(
                          textStyle: TextStyle(
                              fontSize: height * 0.03, color: Colors.brown),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    gender
                        ? Container(
                            width: height * 0.1,
                            height: height * 0.1,
                            child: Image.asset(
                              'assets/female.png',
                              color: Colors.pink[200],
                            ),
                          )
                        : Container(
                            width: height * 0.1,
                            height: height * 0.1,
                            child: Image.asset(
                              'assets/male.png',
                              color: Colors.blueGrey[100],
                            ),
                          ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    gender
                        ? Container(
                            child: Text(
                              '여자 아이',
                              style: GoogleFonts.jua(
                                textStyle: TextStyle(
                                    fontSize: height * 0.03,
                                    color: Colors.pink[200]),
                              ),
                            ),
                          )
                        : Container(
                            child: Text(
                              '남자 아이',
                              style: GoogleFonts.jua(
                                textStyle: TextStyle(
                                    fontSize: height * 0.03,
                                    color: Colors.blueGrey[200]),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      width: width * 0.4,
                      child: Padding(
                        padding: EdgeInsets.only(top: width * 0.05),
                        child: LiteRollingSwitch(
                          value: true,
                          textOn: Text(
                            '  女',
                            style: GoogleFonts.kosugiMaru(
                                color: Colors.white, fontSize: width * 0.06),
                          ),
                          textOff: Text(
                            '  男',
                            style: GoogleFonts.kosugiMaru(
                                color: Colors.white, fontSize: width * 0.06),
                          ),
                          colorOn: Colors.pink[200],
                          colorOff: Colors.blueGrey[100],
                          iconOn: ImageIcon(
                            AssetImage('assets/female.png'),
                            color: Colors.pink.withOpacity(0.4),
                          ),
                          iconOff: ImageIcon(
                            AssetImage('assets/male.png'),
                            color: Colors.blueGrey.withOpacity(0.3),
                          ),
                          onChanged: (gender) {
                            print('Gender is ${(gender) ? 'Female' : 'Male'}');
                          },
                          onTap: () {
                            setState(() {
                              gender == false ? gender = true : gender = false;
                            });
                            print(gender);
                          },
                          onSwipe: () {
                            setState(() {
                              gender == false ? gender = true : gender = false;
                            });
                            print(gender);
                          },
                          onDoubleTap: () {
                            setState(() {
                              gender == false ? gender = true : gender = false;
                            });
                            print(gender);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: Container(
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CatChooseSpeciesScreen(
                                      gender: gender,
                                    )));
                      },
                      child: Text(
                        '다음',
                        style: GoogleFonts.jua(
                            fontSize: width * 0.05, color: Colors.brown),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
