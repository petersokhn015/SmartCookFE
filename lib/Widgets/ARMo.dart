import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

class ARMo extends StatefulWidget {
  const ARMo({Key key}) : super(key: key);

  @override
  State<ARMo> createState() => _ARMoState();
}

class _ARMoState extends State<ARMo> {
  ArCoreController arCoreController;

  final cubePosition = vector.Vector3(0, 0, -1);

  final cube = ArCoreCube(
    materials: [
      ArCoreMaterial(
        color: Colors.blue,
      ),
    ],
    size: vector.Vector3(0.2, 0.2, 0.2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: onArCoreViewCreated,
      ),
    );
  }

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    arCoreController.addArCoreNode(
      ArCoreNode(
        shape: cube,
        position: cubePosition,
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
