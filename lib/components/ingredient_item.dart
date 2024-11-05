import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IngredientItem extends StatelessWidget {
  final String quantity, measure, food, imageUrl;
  const IngredientItem({
    super.key,
    required this.quantity,
    required this.food,
    required this.measure,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var myBox = Hive.box('shopping');
    return Container(
      margin: EdgeInsets.symmetric(vertical: h * .01, horizontal: w * .033),
      padding: EdgeInsets.only(
        top: h * .008,
        bottom: h * .008,
        left: h * .008,
        right: w * .08,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl.isNotEmpty
                  ? imageUrl
                  : 'https://via.placeholder.com/150',
              width: w * .2,
              height: h * .1,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: w * .03, right: w * .03),
              child: Text(
                "$food\n$quantity $measure",
                style: TextStyle(
                  fontSize: w * .04,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(width: w * .033),
          ValueListenableBuilder(
            valueListenable: myBox.listenable(),
            builder: (context, box, _) {
              bool exist = box.containsKey(food);
              if (exist) {
                return GestureDetector(
                  onTap: () {
                    myBox.delete(food);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted')));
                  },
                  child: Icon(
                    Icons.done,
                    color: Colors.green,
                    size: w * .07,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    String value = '$food $measure $quantity';
                    myBox.put(food, value);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item added')));
                  },
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    size: w * .07,
                    color: Colors.red,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
