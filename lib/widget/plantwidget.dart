import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../UIscreen/constant.dart';
import '../UIscreen/detailpage.dart';
import '../model/plant.dart';

class PlantWidget extends StatelessWidget {
  final int index;
  final List<Plant> plantList;

  const PlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: DetailPage(
              plant: plantList[index],
            ),
            type: PageTransitionType.leftToRight,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Plant Image Section
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          plantList[index].imageURL,
                          fit: BoxFit.cover,
                          height: 70.0,
                          width: 70.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                // Plant Details (Category & Name)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plantList[index].category,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      plantList[index].plantName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Price Section
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                '₹${plantList[index].price.toString()}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
