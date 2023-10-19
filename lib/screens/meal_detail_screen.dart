import 'package:flutter/material.dart';
import '../dummy.data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MealDetail extends StatelessWidget {
  final Function toggleFavorite;
  final Function isMealFavorite;
  const MealDetail(this.toggleFavorite, this.isMealFavorite, {super.key});
  static const routeName = '/meal_detail';
//builder methods
  Widget buildSectiontitle(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId; //this return true if the id is matched
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: selectedMeal.imageUrl,
                progressIndicatorBuilder: (context, url, progress) =>
                    const CircularProgressIndicator(
                  color: Colors.red,
                ),
                errorWidget: ((context, url, error) => const Icon(
                      Icons.error,
                      size: 40,
                    )),
                fit: BoxFit.cover,
              ),

              // child: Image.network(
              //   selectedMeal.imageUrl,
              //   fit: BoxFit.cover,
              // ),
            ),
            buildSectiontitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(181, 233, 30, 98),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        selectedMeal.ingredients[index],
                      ),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectiontitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${(index + 1)}'),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
          size: 30,
          //color: Colors.white,
        ),
      ),
    );
  }
}
