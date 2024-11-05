import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipeapp/components/circle_button.dart';
import 'package:recipeapp/components/custom_clip_path.dart';
import 'package:recipeapp/components/ingredient_list.dart';
import 'package:recipeapp/constants/share.dart';
import 'package:recipeapp/constants/show_detail_dialog.dart';
import 'package:recipeapp/constants/show_table.dart';
import 'package:recipeapp/constants/start_cooking.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('saved');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String time = widget.item['totalTime'].toString();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: h * .44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.item['image']),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: h * .04,
                  left: w * .05,
                  child: const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: BackButton(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.item['label'],
                    style: TextStyle(
                      fontSize: w * .05,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text("$time min"),
                  SizedBox(height: h * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ShareRecipe.share(widget.item['url']);
                        },
                        child: const CircleButton(
                          icon: Icons.share,
                          label: 'Share',
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: myBox.listenable(),
                          builder: (context, box, _) {
                            String key = widget.item['label'];
                            bool saved = myBox.containsKey(key);
                            if (saved) {
                              return GestureDetector(
                                onTap: () {
                                  myBox.delete(key);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(milliseconds: 3),
                                          content: Text('Recipe delete')));
                                },
                                child: const CircleButton(
                                  icon: Icons.bookmark,
                                  label: 'Saved',
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  myBox.put(key, key);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(milliseconds: 3),
                                          content: Text('Recipe saved')));
                                },
                                child: const CircleButton(
                                  icon: Icons.bookmark_border,
                                  label: 'Save',
                                ),
                              );
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          final nutrients = widget.item['totalNutrients'];
                          if (nutrients != null &&
                              nutrients is Map<String, dynamic>) {
                            ShowDialog.showCalories(nutrients, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Nutrient information is not available')),
                            );
                          }
                        },
                        child: const CircleButton(
                          icon: Icons.monitor_heart_outlined,
                          label: 'Calories',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ShowTable.showTable(context);
                        },
                        child: const CircleButton(
                          icon: Icons.table_chart_outlined,
                          label: 'Unit chart',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Direction',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * .06,
                        ),
                      ),
                      SizedBox(
                        width: w * .34,
                        child: ElevatedButton(
                          onPressed: () {
                            StartCooking.startCooking(widget.item['url']);
                          },
                          child: const Text('Start'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * .02),
                  Container(
                    height: h * .07,
                    width: w,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipPath(
                            clipper: CustomClipPath(),
                            child: Container(
                              height: h,
                              color: Colors.redAccent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w * .02),
                                    child: Text(
                                      "Ingrediants Required",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: w * .05,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text('6\nItems'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 1.8,
                    child: IngredientList(
                      ingredients: widget.item['ingredients'],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
