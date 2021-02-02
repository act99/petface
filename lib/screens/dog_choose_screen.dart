import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petface/main.dart';
import 'package:petface/screens/dog_loading_screen.dart';
import 'package:petface/tflite/photo_helper.dart';
import 'package:tflite/tflite.dart';
import 'package:petface/screens/dog_choose_gender_screen.dart';

class DogChooseSpeciesScreen extends StatefulWidget {
  final bool gender;
  DogChooseSpeciesScreen({this.gender});

  @override
  _DogChooseSpeciesScreenState createState() => _DogChooseSpeciesScreenState();
}

class _DogChooseSpeciesScreenState extends State<DogChooseSpeciesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // pageview

  // pick image
  File _imageFile1;
  dynamic _pickImageError1;
  String _retrieveDataError1;

  bool _loading = false;
  bool _loading1 = false;
  ImagePicker _picker = ImagePicker();

  List outputs1;

  @override
  void initState() {
    super.initState();
    TFLiteHelper.loadModelDog().then((value) {
      setState(() {
        TFLiteHelper.modelLoaded = true;
        _loading = true;
      });
    });
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    super.dispose();
  }

  Widget _addPhoto1(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 1,
      decoration: BoxDecoration(
        color: Colors.transparent,
        // widget.gender
        //     ? Colors.pink.withOpacity(0.1)
        //     : Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '사진을 골라주세요',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.03,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '여백, 핸드폰 버튼 등이 나오면 부정확합니다.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.02,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '이미지만 나온 "사진"을 골라주세요.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: width * 0.036,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed1(ImageSource.gallery,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '갤러리',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed1(ImageSource.camera,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.camera_fill,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '카메라',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewImage1(BoxFit option) {
    final Text retrieveError = _getRetrieveErrorWidget1();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile1 != null) {
      if (kIsWeb) {
        return Image.network(
          _imageFile1.path,
          fit: option,
        );
      } else {
        return Semantics(
            child: Image.file(
                File(
                  _imageFile1.path,
                ),
                fit: option),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError1 != null) {
      return Text(
        'Pick image error: $_pickImageError1',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    double getNumber(double input, {int precision = 2}) => double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
    return _loading
        ? Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldkey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              shadowColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              iconTheme: IconThemeData(
                color: widget.gender
                    ? Colors.pink.withOpacity(0.3)
                    : Colors.blueGrey.withOpacity(0.7), //change your color here
              ),
              elevation: 0.0,
              title: Text(
                '사진 고르기',
                style: GoogleFonts.hiMelody(
                    textStyle: TextStyle(
                  fontSize: width * 0.06,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.2)
                      : Colors.blueGrey.withOpacity(0.7),
                )),
              ),
            ),
            body: SafeArea(
              child: Center(
                  child: !kIsWeb
                      // && defaultTargetPlatform == TargetPlatform.android
                      ? FutureBuilder<void>(
                          future: retrieveLostData1(),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return RaisedButton(
                                    child: Text("오류! 돌아가기"),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()));
                                    });
                              case ConnectionState.waiting:
                                return const Text(
                                  '잠시만 기다려주세요.',
                                  textAlign: TextAlign.center,
                                );
                              case ConnectionState.done:
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30)),
                                          color: widget.gender
                                              ? Colors.pink.withOpacity(0.1)
                                              : Colors.blueGrey
                                                  .withOpacity(0.1)),
                                      width: width * 1,
                                      height: height * 0.7,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(30),
                                            child: _imageFile1 != null
                                                ? Container(
                                                    height: height * 0.4,
                                                    child: _previewImage1(
                                                        BoxFit.cover))
                                                : _addPhoto1(context),
                                          ),
                                          _imageFile1 != null
                                              ? Container(
                                                  padding: EdgeInsets.all(30),
                                                  child: Text(
                                                    "${outputs1[0]["label"]} ${getNumber(outputs1[0]["confidence"]) * 100}%",
                                                    style: GoogleFonts.jua(
                                                      fontSize: width * 0.05,
                                                      color: widget.gender
                                                          ? Colors.pink
                                                              .withOpacity(0.3)
                                                          : Colors.blueGrey
                                                              .withOpacity(0.7),
                                                    ),
                                                  ))
                                              : Container()
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: width * 0.00),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DogChooseGenderScreen()));
                                              },
                                              child: Text(
                                                '< 이전',
                                                style: GoogleFonts.jua(
                                                  fontSize: width * 0.05,
                                                  color: widget.gender
                                                      ? Colors.pink
                                                          .withOpacity(0.3)
                                                      : Colors.blueGrey
                                                          .withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: _imageFile1 != null
                                                ? Container(
                                                    width: width * 0.3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        _imageFile1 = null;
                                                        setState(() {
                                                          _loading1 = false;
                                                        });
                                                      },
                                                      child: Text(
                                                        '재선택',
                                                        style: GoogleFonts.jua(
                                                          fontSize:
                                                              width * 0.05,
                                                          color: widget.gender
                                                              ? Colors.pink
                                                                  .withOpacity(
                                                                      0.3)
                                                              : Colors.blueGrey
                                                                  .withOpacity(
                                                                      0.7),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: width * 0.3,
                                                  ),
                                          ),
                                          _loading1
                                              ? Container(
                                                  width: width * 0.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DogChooseScreen(
                                                                    gender: widget
                                                                        .gender,
                                                                    imageFile1:
                                                                        _imageFile1,
                                                                  )));
                                                    },
                                                    child: Text(
                                                      '다음 >',
                                                      style: GoogleFonts.jua(
                                                        fontSize: width * 0.05,
                                                        color: widget.gender
                                                            ? Colors.pink
                                                                .withOpacity(
                                                                    0.3)
                                                            : Colors.blueGrey
                                                                .withOpacity(
                                                                    0.7),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: width * 0.3,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Color(0xfff8a0d3)),
                                                ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                    )
                                  ],
                                );

                              default:
                                if (snapshot.hasError) {
                                  return Text(
                                    'Pick image/video error: ${snapshot.error}}',
                                    textAlign: TextAlign.center,
                                  );
                                } else {
                                  return const Text(
                                    '',
                                    textAlign: TextAlign.center,
                                  );
                                }
                            }
                          },
                        )
                      : Container()),
            ),
          )
        : Center(
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
  }

  Future<void> retrieveLostData1() async {
    final LostData response1 = await _picker.getLostData();
    final LostData response2 = await _picker.getLostData();
    if (response1.isEmpty && response2.isEmpty) {
      return;
    }
    if (response1.file != null && response2.file != null) {
      setState(() {
        _imageFile1 = File(response1.file.path);
      });
    } else {
      _retrieveDataError1 = response1.exception.code;
    }
  }

  Text _getRetrieveErrorWidget1() {
    if (_retrieveDataError1 != null) {
      final Text result = Text(_retrieveDataError1);
      _retrieveDataError1 = null;
      return result;
    }
    return null;
  }

  classifyImage1(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      print(output);
      outputs1 = output;
      _loading1 = true;
    });
  }

  void _onImageButtonPressed1(ImageSource source,
      {BuildContext context}) async {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile1 = File(pickedFile.path);
      });
      classifyImage1(File(pickedFile.path));
    } catch (e) {
      setState(() {
        _pickImageError1 = e;
      });
    }
  }
}

class DogChooseScreen extends StatefulWidget {
  final bool gender;
  final File imageFile1;
  DogChooseScreen({this.gender, this.imageFile1});
  @override
  _DogChooseScreenState createState() => _DogChooseScreenState();
}

class _DogChooseScreenState extends State<DogChooseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // pageview

  // pick image

  bool _loading = false;
  bool _loading1 = false;

  List outputs1;
// ------------- tflite tools & image picker tools

  @override
  void initState() {
    super.initState();
    widget.gender
        ? TFLiteHelper.loadModelFemale().then((value) {
            setState(() {
              TFLiteHelper.modelLoaded = true;
              _loading = true;
              print("femaleModel clear");
            });
          })
        : TFLiteHelper.loadModelMale().then((value) {
            setState(() {
              TFLiteHelper.modelLoaded = true;
              _loading = true;
            });
          });
    classifyImage1(widget.imageFile1);
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    super.dispose();
  }

  Widget _previewImage1(BoxFit option) {
    if (widget.imageFile1 != null) {
      if (kIsWeb) {
        return Image.network(
          widget.imageFile1.path,
          fit: option,
        );
      } else {
        return Semantics(
            child: Image.file(
                File(
                  widget.imageFile1.path,
                ),
                fit: option),
            label: 'image_picker_example_picked_image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return _loading
        ? Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldkey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              shadowColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              iconTheme: IconThemeData(
                color: widget.gender
                    ? Colors.pink.withOpacity(0.3)
                    : Colors.blueGrey.withOpacity(0.7), //change your color here
              ),
              elevation: 0.0,
              title: Text(
                '사진 고르기',
                style: GoogleFonts.hiMelody(
                    textStyle: TextStyle(
                  fontSize: width * 0.06,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.2)
                      : Colors.blueGrey.withOpacity(0.7),
                )),
              ),
            ),
            body: SafeArea(
                child: Center(
                    child: !kIsWeb
                        // && defaultTargetPlatform == TargetPlatform.android
                        ? Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    color: widget.gender
                                        ? Colors.pink.withOpacity(0.1)
                                        : Colors.blueGrey.withOpacity(0.1)),
                                width: width * 1,
                                height: height * 0.7,
                                child: Container(
                                  padding: EdgeInsets.all(70),
                                  child: widget.imageFile1 != null
                                      ? Column(
                                          children: [
                                            Container(
                                                height: height * 0.4,
                                                child: _previewImage1(
                                                    BoxFit.cover)),
                                            SizedBox(
                                              height: height * 0.05,
                                            ),
                                            Text(
                                              '이 사진으로 분석을 시작합니다.',
                                              style: GoogleFonts.jua(
                                                fontSize: width * 0.05,
                                                color: widget.gender
                                                    ? Colors.pink
                                                        .withOpacity(0.3)
                                                    : Colors.blueGrey
                                                        .withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        )
                                      : RaisedButton(
                                          child: Text("오류! 돌아가기"),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyApp()));
                                          }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: width * 0.00),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DogChooseGenderScreen()));
                                        },
                                        child: Text(
                                          '< 이전',
                                          style: GoogleFonts.jua(
                                            fontSize: width * 0.05,
                                            color: widget.gender
                                                ? Colors.pink.withOpacity(0.3)
                                                : Colors.blueGrey
                                                    .withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ),
                                    _loading1
                                        ? Container(
                                            width: width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DogLoadingScreen(
                                                              gender:
                                                                  widget.gender,
                                                              imageFile1: widget
                                                                  .imageFile1,
                                                              output1: outputs1,
                                                              loading1:
                                                                  _loading1,
                                                            )));
                                              },
                                              child: Text(
                                                '분석하기 >',
                                                style: GoogleFonts.jua(
                                                  fontSize: width * 0.05,
                                                  color: widget.gender
                                                      ? Colors.pink
                                                          .withOpacity(0.3)
                                                      : Colors.blueGrey
                                                          .withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: width * 0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Color(0xfff8a0d3)),
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 60,
                              )
                            ],
                          )
                        : Container(
                            child: RaisedButton(
                                child: Text("에러"),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                }),
                          ))))
        : Center(
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
  }

  classifyImage1(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      print(output);
      outputs1 = output;
      _loading1 = true;
    });
  }
}
