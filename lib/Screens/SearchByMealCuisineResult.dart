import 'package:flutter/material.dart';

import '../Models/Recipe.dart';
import '../Services/RecipeService/RecipeService.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/LoadingCard.dart';
import '../Widgets/clickableCardWidget.dart';
import 'RecipeDetailsPage.dart';

class SearchByMealCuisineResult extends StatefulWidget {
  final String querySearch;
  final String searchType;
  SearchByMealCuisineResult({Key key, this.querySearch, this.searchType})
      : super(key: key);

  @override
  State<SearchByMealCuisineResult> createState() =>
      _SearchByMealCuisineResultState();
}

class _SearchByMealCuisineResultState extends State<SearchByMealCuisineResult> {
  RecipeService service = RecipeService();

  Future<List<Recipe>> callSpecificFunction() async {
    if (widget.searchType == "cuisine") {
      return await service
          .searchRecipesByCuisineType(widget.querySearch.toLowerCase());
    } else {
      return await service.searchRecipe(widget.querySearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Search for ",
                style: TextStyle(
                  color: ColorSet.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: widget.querySearch,
                style: const TextStyle(
                  color: ColorSet.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorSet.blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Recipe>>(
            future: callSpecificFunction(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recipe> recipes = snapshot.data;
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(recipes.length, (index) {
                    return ClickableCard(
                        imagePath: recipes[index].image,
                        text: recipes[index].title,
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        RecipeDetailsPage(
                                            recipeId: recipes[index].id),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    SmartCookAnimation.PageRouteAnimation(
                                        animation, child),
                              ));
                        });
                  }),
                );
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(8, (index) {
                    return LoadingCard(
                        width: MediaQuery.of(context).size.height / 4,
                        height: MediaQuery.of(context).size.height / 4.5);
                  }),
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
