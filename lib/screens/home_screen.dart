import 'package:flutter/material.dart';
import 'package:recipeapp/components/home_app_bar.dart';
import 'package:recipeapp/components/tab_bar_widget.dart';
import 'package:recipeapp/components/text_field_widget.dart';
import 'package:recipeapp/constants/images_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                SizedBox(height: h * .022),
                const TextFieldWidget(),
                SizedBox(height: h * .022),
                Container(
                  height: h * .25,
                  width: w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImagesPath.explore),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
                SizedBox(height: h * .023),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: w * .045, fontWeight: FontWeight.bold),
                    ),
                    const Text("See all"),
                    SizedBox(width: w * .022),
                  ],
                ),
                SizedBox(height: h * .022),
                const TabBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
