import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petface/admob/admob_manager.dart';
import 'package:petface/screens/dog_photo_screen.dart';
import 'package:petface/screens/cat_photo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "닮았개냥",
    theme: ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: false,
    home: LoadingScreen(),
  ));
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  startTimer() async {
    var duration = Duration(milliseconds: 2500);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  void initState() {
    super.initState();

    startTimer();
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
      backgroundColor: Color(0xfff0d9bc),
      body: Container(
        decoration: BoxDecoration(color: Color(0xfff0d9bc)),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '나의 반려동물과',
                  style: GoogleFonts.jua(
                    textStyle:
                        TextStyle(fontSize: width * 0.056, color: Colors.white),
                  ),
                ),
                Text(
                  '닮은 연예인 찾기',
                  style: GoogleFonts.jua(
                    textStyle:
                        TextStyle(fontSize: width * 0.096, color: Colors.white),
                  ),
                ),
                Container(
                  width: height * 0.35,
                  height: height * 0.35,
                  child: Image.asset('assets/dog.jpg'),
                ),
                Text(
                  '나는 누구 닮았개?',
                  style: GoogleFonts.jua(
                    textStyle:
                        TextStyle(fontSize: width * 0.036, color: Colors.white),
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  width: height * 0.2,
                  height: height * 0.2,
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: Image.asset(
                      'assets/loading.gif',
                      color: Colors.white,
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // 남녀 프로세스

  // 바텀내비게이션
  int selectedIndex = 0;
  AdmobManager adMob = AdmobManager();
  bool species = true;

  @override
  void initState() {
    super.initState();
    adMob.init();
    adMob.showBannerAd();
  }

  @override
  void dispose() {
    adMob?.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    List<Widget> _widgetOptions = <Widget>[
      DogPhotoScreen(),
      CatPhotoScreen()
      // MorePhotoScreen(
      //   gender: gender,
      // ),
    ];

    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: _widgetOptions.elementAt(selectedIndex),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.15, vertical: height * 0.09),
            child: Container(
              child: GNav(
                  gap: 8,
                  color: Color(0xfff0d9bc),
                  activeColor: Colors.white,
                  iconSize: 24,
                  tabBackgroundColor:
                      species ? Color(0xfff0d9bc) : Color(0xffffd5fb),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 1000),
                  tabs: [
                    GButton(
                      leading: Image.asset(
                        "assets/dog_icon.png",
                        width: width * 0.06,
                      ),
                      text: '반려견',
                    ),
                    GButton(
                      leading: Image.asset(
                        "assets/cat_icon.png",
                        width: width * 0.05,
                      ),
                      text: '반려묘',
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    print(index);
                    setState(() {
                      selectedIndex = index;
                      species = !species;
                    });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
