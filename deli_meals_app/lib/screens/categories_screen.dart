import 'package:deli_meals_app/widgets/category_item.dart';
import 'package:deli_meals_app/dummy_data.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(
          25,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map(
          (catData) {
            return CategoryItem(
              catData.id,
              catData.title,
              catData.color,
            );
          },
        ).toList(),
      );
  }
}
