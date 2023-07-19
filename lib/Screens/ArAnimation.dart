import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;

  //String localObjectReference;
  ARNode localObjectNode;

  //String webObjectReference;
  ARNode webObjectNode;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ARView(
      onARViewCreated: onARViewCreated,
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    // 1
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    // 2
    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    // 3
    this.arObjectManager.onInitialize();
  }

  Future<void> onLocalObjectButtonPressed() async {
    // 1
    if (localObjectNode != null) {
      arObjectManager.removeNode(localObjectNode);
      localObjectNode = null;
    } else {
      // 2
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/Chicken_01/Chicken_01.gltf",
          scale: vector.Vector3(0.2, 0.2, 0.2),
          position: vector.Vector3(0.0, 0.0, 0.0),
          rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0));
      // 3
      bool didAddLocalNode = await arObjectManager.addNode(newNode);
      localObjectNode = (didAddLocalNode) ? newNode : null;
    }
  }
}
