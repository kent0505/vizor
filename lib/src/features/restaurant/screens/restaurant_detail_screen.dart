import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';
import '../models/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key, required this.restaurant});

  static const routePath = '/RestaurantDetailScreen';

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: restaurant.title,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [],
      ),
    );
  }
}
