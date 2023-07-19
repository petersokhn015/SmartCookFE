import 'dart:async';
import 'dart:math';

import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:detecttestapppp/views/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_3d_obj/flutter_3d_obj.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../Utils/GlbLinks.dart';
import '../Utils/colors.dart';

class LocalAndWebObjectsView extends StatefulWidget {
  final List<String> instructions;

  const LocalAndWebObjectsView({Key key, @required this.instructions})
      : super(key: key);

  @override
  State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
}

class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView>
    with SingleTickerProviderStateMixin {
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;
  ARNode localObjectNode;
  ARNode webObjectNode;
  AnimationController _animationController;
  double _initialY = 0.0;
  Timer _timer;

  int _currentStep = 0;

  void _handleNextPress() async {
    setState(() {
      if (_currentStep < widget.instructions.length - 1) {
        _currentStep++;
      }
    });

    await onWebObjectAtButtonPressed(glbLinks[_currentStep]);
  }

  void _handlePreviousPress() async {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });

    await onWebObjectAtButtonPressed(glbLinks[_currentStep]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomCircularStepper(
                  instructions: widget.instructions,
                  currentStep: _currentStep,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      color: Colors.black,
                      child: ARView(
                        onARViewCreated: onARViewCreated,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _currentStep > 0 ? _handlePreviousPress : null,
                      color: _currentStep > 0
                          ? ColorSet.primaryColor
                          : Colors.grey,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _currentStep < widget.instructions.length - 1
                          ? _handleNextPress
                          : null,
                      color: _currentStep < widget.instructions.length - 1
                          ? ColorSet.primaryColor
                          : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    // 1
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    // 2
    this.arSessionManager.onInitialize(
        showFeaturePoints: false,
        showPlanes: false,
        customPlaneTexturePath: "triangle.png",
        showWorldOrigin: true,
        handleTaps: false,
        showAnimatedGuide: false);
    // 3
    this.arObjectManager.onInitialize();

    //4
    await onWebObjectAtButtonPressed(glbLinks[_currentStep]);
  }

  Future<void> onWebObjectAtButtonPressed(String glbLink) async {
    if (webObjectNode != null) {
      arObjectManager.removeNode(webObjectNode);
    }

    var newNode = ARNode(
      type: NodeType.webGLB,
      uri: glbLink,
      scale: vector.Vector3(0.1, 0.1, 0.1),
      position: vector.Vector3(0, 0, 0),
    );
    bool didAddWebNode = await arObjectManager.addNode(newNode);
    webObjectNode = (didAddWebNode) ? newNode : null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
