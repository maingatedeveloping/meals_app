import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealsDescription extends StatelessWidget {
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealsDescription({
    required this.duration,
    required this.complexity,
    required this.affordability,
    super.key,
  });

  String get complexityText {
    if (complexity == Complexity.Simple) {
      return 'Simple';
    } else if (complexity == Complexity.Challenging) {
      return 'Challenging';
    } else if (complexity == Complexity.Hard) {
      return 'Hard';
    } else {
      return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Luxurious:
        return 'Expensive';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unknwon';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color textColor = Colors.black;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.schedule),
              const SizedBox(
                width: 6,
              ),
              Text(
                '$duration min',
                style: const TextStyle(color: textColor),
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.work),
              const SizedBox(
                width: 6,
              ),
              Text(
                complexityText,
                style: const TextStyle(color: textColor),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.attach_money),
              const SizedBox(
                width: 6,
              ),
              Text(
                affordabilityText,
                style: const TextStyle(color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
