import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/Recipe.dart';
import '../Screens/RecipeDetailsPage.dart';
import '../Services/RecipeService/RecipeService.dart';
import '../Utils/Animation.dart';
import 'LoadingCard.dart';

class CarouselSliderTeif extends StatefulWidget {
  final String email;

  const CarouselSliderTeif({key, this.email});
  @override
  _CarouselSliderTeifState createState() => _CarouselSliderTeifState();
}

class _CarouselSliderTeifState extends State<CarouselSliderTeif> {
  @override
  Widget build(BuildContext context) {
    RecipeService _service = new RecipeService();

    return FutureBuilder<List<Recipe>>(
        future: _service.getRecommendedRecipes(widget.email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 4.5,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: data?.map((recipe) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      RecipeDetailsPage(recipeId: recipe.id),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: recipe.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching data');
          } else {
            return LoadingCard(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
            );
          }
        });
  }
}
