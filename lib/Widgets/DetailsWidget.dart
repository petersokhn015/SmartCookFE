import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class Details extends StatelessWidget {
  final String image;
  final IconData favoriteIcon;
  final Color favoriteIconColor;
  final IconData backIcon;
  final VoidCallback onFavoritePressed;
  final VoidCallback onBackPressed;

  const Details({
    key,
    this.image,
    this.favoriteIcon,
    this.favoriteIconColor,
    this.backIcon,
    this.onFavoritePressed,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: ColorSet.blackColor.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(backIcon),
                      onPressed: onBackPressed,
                      color: ColorSet.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: ColorSet.blackColor.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(favoriteIcon),
                      onPressed: onFavoritePressed,
                      color: favoriteIconColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
