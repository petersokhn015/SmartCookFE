import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  ClickableCard({
    this.imagePath,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.height / 4,
        height: MediaQuery.of(context).size.height / 4.5,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height / 2.5,
              height: MediaQuery.of(context).size.height / 4.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height / 2.5,
              height: MediaQuery.of(context).size.height / .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
