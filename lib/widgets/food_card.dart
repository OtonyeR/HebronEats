import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../screens/food_details_screen.dart';
import '../models/food.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(this.food, {Key? key}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => FoodDetailScreen(food)));
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 195,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(food.imgUrl),
                          scale: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 0.6,
                        ),
                      ]),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: overTag1(
                    Text(
                      food.category,
                      style: kOverTagText1,
                    ),
                  ),
                ),
                Positioned(
                    child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 140),
                      height: 55,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 150,
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(
                                  color: kBackground,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: .6,
                                      spreadRadius: 0.4,
                                      color: subText,
                                    )
                                  ]),
                            ),
                            Text(
                              food.vendorName,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kBackground,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
