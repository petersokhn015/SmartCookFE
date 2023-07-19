import 'dart:ui' as ui;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewOverlay extends StatefulWidget {
  @override
  _ARViewOverlayState createState() => _ARViewOverlayState();
}

class _ARViewOverlayState extends State<ARViewOverlay> {
  ArCoreController arCoreController;
  bool _isRectangleVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isRectangleVisible ? Icons.clear : Icons.add),
        onPressed: () {
          if (_isRectangleVisible) {
            // Remove the rectangle node from the AR scene
            arCoreController?.removeNode(nodeName: "rectangle");
          } else {
            // Add a rectangle node to the AR scene
          }
          setState(() {
            _isRectangleVisible = !_isRectangleVisible;
          });
        },
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    this.arCoreController = controller;
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
