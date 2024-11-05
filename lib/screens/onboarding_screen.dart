import 'package:flutter/material.dart';
import 'package:recipeapp/constants/images_path.dart';
import 'package:recipeapp/screens/home.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final h = constraints.maxHeight;
          final w = constraints.maxWidth;
          return SizedBox(
            height: h,
            width: w,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: h * .79,
                    width: w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ImagesPath.onBoardingTitle,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Image.asset(ImagesPath.onBoardingTitle),
                // ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: h * 0.3, // Adjusted for better responsiveness
                    width: w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: h * 0.04), // Adjusted padding
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Lets cook good food",
                              style: TextStyle(
                                fontSize: w * 0.06,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            const Text(
                              "Check out the app and start cooking delicious meals!",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: h * 0.04),
                            SizedBox(
                              width: w * 0.8,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                },
                                child: const Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
