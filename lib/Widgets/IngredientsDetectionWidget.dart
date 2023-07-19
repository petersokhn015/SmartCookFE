import 'dart:collection';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../Models/NutritionFacts.dart';
import '../Screens/Search.dart';
import '../Services/RecipeService/NutritionFactsService.dart';
import '../States/IngredientsProvider.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../main.dart';

class IngredientsDetectionWidget extends StatefulWidget {
  const IngredientsDetectionWidget({Key key}) : super(key: key);

  @override
  State<IngredientsDetectionWidget> createState() =>
      _IngredientsDetectionWidgetState();
}

class _IngredientsDetectionWidgetState
    extends State<IngredientsDetectionWidget> {
  CameraController cameraController;
  CameraImage cameraImage;
  List recognitionsList;
  final List<String> specificClasses = ['apple', 'banana', 'orange'];
  NutritionFactService service = NutritionFactService();

  initCamera() async {
    cameraController = CameraController(cameras[0], ResolutionPreset.low);
    cameraController.initialize().then((value) {
      setState(() {
        cameraController.startImageStream((image) => {
              cameraImage = image,
              runModel(),
            });
      });
    });
  }

  runModel() async {
    recognitionsList = await Tflite.detectObjectOnFrame(
      bytesList: cameraImage.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.1,
    );

    setState(() {
      cameraImage;
    });
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
        model: TfliteURLs.tfliteModelURL, labels: TfliteURLs.tfliteLabelsURL);
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.stopImageStream();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  _showPopup(String objectName, double confidence) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: service.fetchNutritionFacts(objectName),
          builder:
              (BuildContext context, AsyncSnapshot<NutritionFacts> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Text("Loading..."),
                content: LinearProgressIndicator(),
              );
            } else {
              var nutrition = snapshot.data;
              return AlertDialog(
                title: Text("${nutrition.name} (${nutrition.caloric})"),
                content: Text(
                    "Carbs: ${nutrition.carbon}\nFat: ${nutrition.fat}\nProtein: ${nutrition.protein}"),
                actions: [
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  List<Widget> displayBoxesAroundRecognizedObjects(
      Size screen, IngredientsProvider ingredientsProvider) {
    if (recognitionsList == null) return [];

    double factorX = screen.width;
    double factorY = screen.height;

    Color colorPick = Colors.pink;

    List<Widget> widgets = [];

    for (var result in recognitionsList) {
      if (specificClasses.contains(result['detectedClass']) &&
          result['confidenceInClass'] >= 0.6) {
        ingredientsProvider.addIngredient(result['detectedClass']);
        widgets.add(
          Positioned(
            left: result["rect"]["x"] * factorX,
            top: result["rect"]["y"] * factorY,
            width: result["rect"]["w"] * factorX,
            height: result["rect"]["h"] * factorY,
            child: GestureDetector(
              onTap: () {
                // _showPopup(
                //     result['detectedClass'], result['confidenceInClass']);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.pink, width: 2.0),
                ),
                child: Text(
                  "${result['detectedClass']}",
                  style: TextStyle(
                    background: Paint()..color = colorPick,
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];
    final ingredientsProvider =
        Provider.of<IngredientsProvider>(context, listen: false);
    ingredientsProvider.removeIngredient();
    list.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: Container(
          height: size.height - 100,
          child: (!cameraController.value.isInitialized)
              ? new Container()
              : AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                ),
        ),
      ),
    );

    if (cameraImage != null) {
      list.addAll(
          displayBoxesAroundRecognizedObjects(size, ingredientsProvider));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorSet.primaryColor,
          onPressed: () {
            String ingredients =
                getIngredientsAsString(ingredientsProvider.ingredients);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResult(
                  fromCamera: ingredients,
                ),
              ),
            );
          },
          child: Icon(
            Icons.chevron_right,
            color: ColorSet.whiteColor,
          ),
        ),
      ),
    );
  }

  String getIngredientsAsString(HashSet<String> ingredients) {
    String result = '';
    for (String ingredient in ingredients) {
      result += '$ingredient ';
    }
    return result.trim();
  }
}
