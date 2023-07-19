import 'package:detecttestapppp/views/testing.dart';
import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import 'localAndWebObjectsView.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({this.title, Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text("AR"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LocalAndWebObjectsView(
                                      instructions: [
                                        'First instruction',
                                        'Second instruction',
                                        'Boil the eggs in boiling water for approximately 9 minutes until desired doneness.',
                                        'Fourth instruction',
                                      ],
                                    )));
                      },
                      child: const Text("Local / Web Objects")),
                ),
              ],
            ),
          )),
    );
  }
}
