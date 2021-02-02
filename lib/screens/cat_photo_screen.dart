import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petface/screens/dog_choose_gender_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:petface/screens/cat_choose_gender_screen.dart';

class CatPhotoScreen extends StatefulWidget {
  @override
  _CatPhotoScreenState createState() => _CatPhotoScreenState();
}

class _CatPhotoScreenState extends State<CatPhotoScreen> {
  _launchURL() async {
    const url = 'https://www.youtube.com/channel/UCQNE2JmbasNYbjGAcuBiRRg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              color: Color(0xffffd5fb)),
          child: Center(
              child: Column(
            children: <Widget>[
              Container(
                  height: height * 0.08,
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Color(0xffffd5fb),
                    onPressed: _launchURL,
                    child: Image.asset('assets/jocoding_banner.png'),
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                '나는 누구닮았냥?',
                style: GoogleFonts.jua(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.096,
                        fontWeight: FontWeight.w100)),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.05),
                width: width * 0.5,
                height: width * 0.5,
                child: Image.asset('assets/cat.jpg'),
              ),
              Text(
                '<Notice>',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '* 재미로만 해주세요!',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                "* 사랑하는 우리 '아이'만 나온 사진을 넣어주세요",
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.048,
                // margin: EdgeInsets.only(top: height * 0.1),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatChooseGenderScreen(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffffd5fb), Colors.pink[200]],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: width * 0.4, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "시작하기",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gothicA1(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.036,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          )),
        ),
      ),
    );
  }
}
