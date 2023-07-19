import 'dart:convert';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARUgh extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARUgh> {
  ArCoreController arCoreController;
  ArCoreNode animatedModelNode;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    final ByteData byteData = await rootBundle.load('assets/ali.glb');
    final String path = utf8.decode(byteData.buffer.asUint8List());

    animatedModelNode = ArCoreReferenceNode(
        name: 'animated_model',
        object3DFileName: path,
        scale: vector.Vector3(0.1, 0.1, 0.1),
        position: vector.Vector3(0, 0, 0));

    arCoreController.addArCoreNode(animatedModelNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _handlePlaneTap;
  }

  void _handlePlaneTap(List<ArCoreHitTestResult> hits) {
    if (hits.isNotEmpty) {
      final hit = hits.first;
      final position = hit.pose.translation;
      final newModelNode = animatedModelNode;
      newModelNode.position.value =
          vector.Vector3(position.x, position.y, position.z);
      arCoreController.addArCoreNode(newModelNode);
    }
  }
}
