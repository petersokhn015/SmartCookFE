import 'dart:io';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Screens/Search.dart';
import '../States/SearchState.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import 'IngredientsDetectionWidget.dart';

class SearchInput extends StatefulWidget {
  SearchInput({key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchState>(context, listen: true);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          width: MediaQuery.of(context).size.width - 85,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
            color: Theme.of(context).brightness == Brightness.light
                ? ColorSet.darkWhiteColor
                : ColorSet.darkGrayColor,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (_, __, ___) => SearchResult(
                    fromCamera: '',
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  CommunityMaterialIcons.magnify,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  StringSet.searchRecipesIngredientsText,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? ColorSet.darkGrayColor
                        : ColorSet.darkWhiteColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 50, // set a specific value for the width
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IngredientsDetectionWidget()),
              );
            },
          ),
        ),
      ],
    );
  }
}
