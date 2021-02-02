import 'dart:async';
import 'dart:io';

import 'package:petface/tflite/app_helper.dart';
import 'package:petface/tflite/realtime_model.dart';
import 'package:tflite/tflite.dart';

class TFLiteHelper {
  static List<Result> _outputs = List();
  static var modelLoaded = false;

  static Future<String> loadModelFemale() async {
    AppHelper.log("loadModel", "Loading model..");

    return Tflite.loadModel(
      model: "assets/model_unquant_female.tflite",
      labels: "assets/labels_female.txt",
    );
  }

  static Future<String> loadModelMale() async {
    AppHelper.log("loadModel", "Loading model..");

    return Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  static Future<String> loadModelDog() async {
    AppHelper.log("loadModel", "Loading model..");

    return Tflite.loadModel(
      model: "assets/model_unquant_dog.tflite",
      labels: "assets/labels_dog.txt",
    );
  }

  static Future<String> loadModelCat() async {
    AppHelper.log("loadModel", "Loading model..");

    return Tflite.loadModel(
      model: "assets/model_unquant_cat.tflite",
      labels: "assets/labels_cat.txt",
    );
  }

  static void disposeModel() {
    Tflite.close();
  }
}
