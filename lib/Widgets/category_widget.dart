import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/global_colors.dart';
import '../services/categorty.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryModel = Provider.of<CategoriesModel>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              height: size.width * 0.45,
              width: size.width * 0.45,
              categoryModel.image.toString(),
              fit: BoxFit.fill,
              errorBuilder: ((context, error, stackTrace) =>
                  const Icon(Icons.error)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              categoryModel.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                backgroundColor: lightCardColor.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
