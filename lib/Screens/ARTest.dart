// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite/tflite.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// import '../main.dart';

// class ARTest extends StatefulWidget {
//   const ARTest({key});

//   @override
//   State<ARTest> createState() => _ARTestState();
// }

// class _ARTestState extends State<ARTest> {
//   CameraController cameraController;
//   ArCoreController arController;
//   CameraImage cameraImage;
//   List recognitionsList;
//   final List<String> specificClasses = ['apple', 'banana', 'orange'];
//   Size screen;

//   @override
//   void dispose() {
//     arController.dispose();
//     cameraController?.stopImageStream();
//     cameraController?.dispose();
//     Tflite.close();
//     super.dispose();
//   }

//   void _onArCoreViewCreated(ArCoreController arCoreController) async {
//     arController = arCoreController;

//     double factorX = screen.width;
//     double factorY = screen.height;

//     if (recognitionsList == null) return;

//     for (var result in recognitionsList) {
//       if (specificClasses.contains(result['detectedClass']) &&
//           result['confidenceInClass'] >= 0.6) {
//         final material = ArCoreMaterial(
//           color: Colors.blue,
//           reflectance: 1.0,
//         );
//         final cuboid = ArCoreCube(
//           materials: [material],
//           size: vector.Vector3(0.2, 0.2, 0.2),
//         );

//         final translation = vector.Vector3(
//           (result["rect"]["x"] - 0.5) * 2 * factorX,
//           -(result["rect"]["y"] - 0.5) * 2 * factorY,
//           -1.0,
//         );

//         arCoreController.addArCoreNodeWithAnchor(
//           ArCoreNode(
//             shape: cuboid,
//             position: translation,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> runModel() async {
//     recognitionsList = await Tflite.detectObjectOnFrame(
//       bytesList: cameraImage.planes.map((plane) {
//         return plane.bytes;
//       }).toList(),
//       imageHeight: cameraImage.height,
//       imageWidth: cameraImage.width,
//       imageMean: 127.5,
//       imageStd: 127.5,
//       numResultsPerClass: 1,
//       threshold: 0.1,
//     );

//     setState(() {});
//   }

//   Future<void> initCamera() async {
//     cameraController = CameraController(cameras[0], ResolutionPreset.low);
//     await cameraController.initialize();
//     cameraController.startImageStream((image) {
//       cameraImage = image;
//       runModel();
//     });
//   }

//   Future<void> loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/ssd_mobilenet.tflite",
//       labels: "assets/ssd_mobilenet.txt",
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     initCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     screen = MediaQuery.of(context).size;

//     List<Widget> list = [];
//     // final ingredientsProvider =
//     //     Provider.of<IngredientsProvider>(context, listen: false);
//     // ingredientsProvider.removeIngredient();
//     list.add(
//       Positioned(
//         top: 0.0,
//         left: 0.0,
//         width: screen.width,
//         height: screen.height,
//         child: Container(
//           height: screen.height - 100,
//           child: (!cameraController.value.isInitialized)
//               ? new Container()
//               : AspectRatio(
//                   aspectRatio: cameraController.value.aspectRatio,
//                   child: CameraPreview(cameraController),
//                 ),
//         ),
//       ),
//     );

//     if (cameraImage != null) {
//       list.add(ArCoreView(
//         onArCoreViewCreated: _onArCoreViewCreated,
//         enableTapRecognizer: true,
//       ));
//     }

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Container(
//           margin: EdgeInsets.only(top: 50),
//           color: Colors.black,
//           child: Stack(
//             children: list,
//           ),
//         ),
//       ),
//     );
//   }
// }
