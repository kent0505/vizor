import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/image_widget.dart';
import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Button(
        onPressed: () {},
        child: Row(
          children: [
            ImageWidget.network(
              getImage(restaurant.photo),
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(restaurant.title),
                Text(restaurant.address),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
