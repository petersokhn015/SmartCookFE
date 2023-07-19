import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Models/RecipeDetails.dart';
import '../Services/RecipeService/RecipeService.dart';
import '../States/RecipeDetailsState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../views/localAndWebObjectsView.dart';

class RecipeDetailsPage extends StatelessWidget {
  int recipeId;
  RecipeDetailsPage({Key key, this.recipeId}) : super(key: key);

  RecipeService service = RecipeService();

  @override
  Widget build(BuildContext context) {
    final recipeDetailsState =
        Provider.of<RecipeDetailsState>(context, listen: true);
    return SafeArea(
      child: FutureBuilder<RecipeDetails>(
          future: service.getRecipeDetails(recipeId.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RecipeDetails recipe = snapshot.data;
              recipeDetailsState.checkIfFavorite(recipeId);
              return Scaffold(
                  floatingActionButton: FloatingActionButton(
                      backgroundColor: ColorSet.primaryColor,
                      onPressed: () {
                        List<String> instructions = [];
                        //List<String> recipeInstructions = ["Instruction 1"];
                        List<String> recipeInstructions = recipe.steps;
                        if (recipeInstructions.length >= 4) {
                          instructions = recipeInstructions.sublist(0, 4);
                        } else {
                          instructions.addAll(recipeInstructions);
                          for (int i = instructions.length; i < 4; i++) {
                            instructions.add('Instruction ${i + 1}');
                          }
                        }

                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LocalAndWebObjectsView(
                                          instructions: instructions),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      },
                      child: Image.asset(
                        ImageUrls.arLogoURL,
                        color: ColorSet.whiteColor,
                      )),
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      recipe.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: recipeDetailsState.isFavorite == true
                              ? ColorSet.primaryColor
                              : ColorSet.lightGrayColor,
                        ),
                        onPressed: () {
                          recipeDetailsState.changeFavoriteIcon(
                              recipe, recipeId);
                        },
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                recipe.image,
                                height: 300,
                                fit: BoxFit.fill,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            width: MediaQuery.of(context).size.width,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? ColorSet.darkWhiteColor
                                  : ColorSet.darkGrayColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      recipe.cookTime.toString(),
                                      style: const TextStyle(
                                          color: ColorSet.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "minutes",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: ColorSet.primaryColor,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      recipe.caloriesAmount.toString(),
                                      style: const TextStyle(
                                          color: ColorSet.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Kcal",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 1,
                                  color: ColorSet.primaryColor,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      recipe.servings.toString(),
                                      style: const TextStyle(
                                          color: ColorSet.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Servings",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(color: ColorSet.primaryColor, thickness: 0.5),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ingredients",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                recipe.ingredientCount.toString() + " items",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorSet.lightGrayColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recipe.ingredientCount,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      recipe.ingredients[index].imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Instructions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: recipe.steps
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${entry.key + 1}.',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                entry.value,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ));
            } else {
              return Scaffold(
                body: Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: ColorSet.primaryColor, size: 40)),
              );
            }
          }),
    );
  }
}
