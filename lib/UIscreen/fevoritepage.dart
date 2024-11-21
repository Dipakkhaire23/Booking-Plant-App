import 'package:flutter/material.dart';

import '../model/plant.dart';
import '../widget/plantwidget.dart';
import 'constant.dart';

class FavoritePage extends StatefulWidget {
  final List<Plant> favoritedPlants;

  const FavoritePage({Key? key, required this.favoritedPlants})
      : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // Toggle favorite status for a plant
  void toggleFavorite(Plant plant) {
    setState(() {
      if (plant.isFavorated) {
        widget.favoritedPlants.remove(plant); // Remove if already favorited
      } else {
        widget.favoritedPlants.add(plant); // Add if not favorited
      }
      plant.isFavorated = !plant.isFavorated; // Toggle the status
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: widget.favoritedPlants.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset('assets/fevorite.png', scale: 1.0,height: 100,width: 100,),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Your favorite plants will appear here!',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: ListView.builder(
          itemCount: widget.favoritedPlants.length,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Plant plant = widget.favoritedPlants[index];
            return PlantWidget(
              index: index,
              plantList: widget.favoritedPlants,
            );
          },
        ),
      ),
    );
  }
}
