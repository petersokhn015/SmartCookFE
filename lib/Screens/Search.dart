import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Recipe.dart';
import '../Services/RecipeService/RecipeService.dart';
import '../States/SearchState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/LoadingCard.dart';
import '../Widgets/appSearchComponent.dart';
import '../Widgets/clickableCardWidget.dart';
import '../Widgets/searchInput.dart';
import 'RecipeDetailsPage.dart';
import 'SearchByMealCuisineResult.dart';

class Search extends StatelessWidget {
  Search({key});
  TextEditingController boyController = TextEditingController();

  List<String> meals = [
    StringSet.breakfastText,
    StringSet.lunchText,
    StringSet.dessertText,
    StringSet.dinnerText
  ];

  List<String> cuisines = [
    StringSet.italianText,
    StringSet.middleEasternText,
    StringSet.americanText,
    StringSet.mexicanText,
    StringSet.thaiText,
    StringSet.indianText,
    StringSet.chineseText,
    StringSet.japaneseText,
  ];

  List<String> cuisinesUrls = [
    ImageUrls.italianURL,
    ImageUrls.middleEastURL,
    ImageUrls.americanURL,
    ImageUrls.mexicanURL,
    ImageUrls.thaiURL,
    ImageUrls.indianURL,
    ImageUrls.chineseURL,
    ImageUrls.japaneseURL
  ];

  List<String> imageUrls = [
    ImageUrls.breakfastURL,
    ImageUrls.lunchURL,
    ImageUrls.dessertURL,
    ImageUrls.dinnerURL
  ];
  List<Color> colors = [
    ColorSet.redColor,
    ColorSet.greenColor,
    ColorSet.blueColor,
    ColorSet.yellowColor
  ];

  InkWell generateMeals(int index, BuildContext context) {
    int colorIndex = Random().nextInt(colors.length);
    return InkWell(
      onTap: () {
        print(meals[index]);
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchByMealCuisineResult(
                      querySearch: meals[index], searchType: "meal"),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SmartCookAnimation.PageRouteAnimation(animation, child),
            ));
      },
      child: AppSearchComponent(
          text: meals[index],
          imageUrl: imageUrls[index],
          color: colors[colorIndex]),
    );
  }

  InkWell generateCuisines(int index, BuildContext context) {
    int colorIndex = Random().nextInt(colors.length);
    return InkWell(
      onTap: () {
        print(cuisines[index]);
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchByMealCuisineResult(
                      querySearch: cuisines[index], searchType: "cuisine"),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SmartCookAnimation.PageRouteAnimation(animation, child),
            ));
      },
      child: AppSearchComponent(
          text: cuisines[index],
          imageUrl: cuisinesUrls[index],
          color: colors[colorIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                StringSet.discoverTitle,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              StringSet.discoverDescription,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            SearchInput(),
            const SizedBox(height: 10),
            const Divider(
              color: ColorSet.primaryColor,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                StringSet.searchByMealTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 500,
              height: 250,
              child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.69,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                      4, (index) => generateMeals(index, context))),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                StringSet.searchByCuisineTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 500,
              height: MediaQuery.of(context).size.height / 1.5,
              child: GridView.count(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.69,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                      8, (index) => generateCuisines(index, context))),
            ),
          ],
        ),
      )),
    );
  }
}

class SearchResult extends StatefulWidget {
  String fromCamera;
  SearchResult({Key key, this.fromCamera}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final _focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  bool isTextFieldEmpty = true;
  bool isLoading = false;
  bool isFinished = false;
  RecipeService service = RecipeService();

  @override
  void initState() {
    super.initState();
    // request focus after the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromCamera != "") {
        setState(() {
          controller.text = widget.fromCamera;
          isTextFieldEmpty = false;
        });
      }
      _focusNode.requestFocus();
    });
    Provider.of<SearchState>(context, listen: false).loadRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = currentBrightness == Brightness.dark;
    return SafeArea(
      child: Consumer<SearchState>(
        builder: (context, recent, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(CommunityMaterialIcons.chevron_left),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              CommunityMaterialIcons.magnify,
                              color: ColorSet.darkGrayColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: StringSet.searchRecipesIngredientsText,
                            hintStyle: TextStyle(
                                color: isDarkMode
                                    ? ColorSet.darkWhiteColor
                                    : ColorSet.darkGrayColor,
                                fontSize: 16),
                            filled: true,
                            fillColor: isDarkMode
                                ? ColorSet.darkGrayColor
                                : ColorSet.darkWhiteColor,
                          ),
                          onSubmitted: (value) async {
                            if (value.isNotEmpty) {
                              //make api call
                              setState(() {
                                isLoading = true;
                              });
                              List<Recipe> result =
                                  await service.searchRecipe(value.trim());
                              setState(() {
                                isLoading = false;
                                isFinished = true;
                              });
                              if (result.isNotEmpty) {
                                recent.setSearchResult(result);
                                recent.setIsResult(true);
                              }
                              recent.setIsResult(false);
                            }
                            recent.addRecentSearch(value);
                          },
                          onChanged: (value) {
                            bool val = false;

                            if (value.isEmpty) {
                              val = true;
                              recent.clearSearchResult();
                            }
                            setState(() {
                              isTextFieldEmpty = val;
                              isFinished = false;
                            });
                          },
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (isTextFieldEmpty == true) ...[
                    const Divider(
                      thickness: 0.5,
                      color: ColorSet.primaryColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          child: const Text('Clear All',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: ColorSet.primaryColor)),
                          onTap: () {
                            recent.clearRecentSearches();
                          },
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: recent.recentSearches.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (controller.text != "") {
                                    controller.text = "";
                                    isTextFieldEmpty = true;
                                  }
                                  controller.text =
                                      recent.recentSearches[index];
                                  isTextFieldEmpty = false;
                                });
                                recent.clearSearchResult();
                              },
                              child: Text(recent.recentSearches[index])),
                          trailing: IconButton(
                            icon: const Icon(
                              CommunityMaterialIcons.close,
                              color: ColorSet.primaryColor,
                            ),
                            onPressed: () {
                              recent.removeSpecificSearch(index);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  // if(recent.isResult == false && isLoading == false) ... [
                  //   Text("No results found")
                  // ],
                  if (isLoading == true) ...[
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(14, (index) {
                        return LoadingCard(
                            width: MediaQuery.of(context).size.height / 4,
                            height: MediaQuery.of(context).size.height / 4.5);
                      }),
                    ),
                  ],
                  if (isTextFieldEmpty == false &&
                      recent.searchResults.isEmpty &&
                      isFinished == true) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                    Center(
                        child: Column(
                      children: [
                        Image.asset(
                          ImageUrls.notFoundURL,
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                        const Text(
                          "Result not found",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ],
                  if (isTextFieldEmpty == false &&
                      recent.searchResults.isNotEmpty) ...[
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children:
                          List.generate(recent.searchResults.length, (index) {
                        return ClickableCard(
                            imagePath: recent.searchResults[index].image,
                            text: recent.searchResults[index].title,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        RecipeDetailsPage(
                                            recipeId:
                                                recent.searchResults[index].id),
                                    transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) =>
                                        SmartCookAnimation.PageRouteAnimation(
                                            animation, child),
                                  ));
                            });
                      }),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
