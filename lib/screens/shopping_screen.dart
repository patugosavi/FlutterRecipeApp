import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipeapp/components/custom_app_bar.dart';
import 'package:recipeapp/constants/share.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    var myBox = Hive.box('shopping');
    return Scaffold(
      appBar: const CustomAppBar(title: 'Shopping', back: false),
      body: ValueListenableBuilder(
          valueListenable: myBox.listenable(),
          builder: (context, box, _) {
            var data = box.values.toList();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      height: h * .085,
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(data[index]),
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                 const PopupMenuItem(
                                  value: 'share',
                                  child: Text('share'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('delete'),
                                ),
                              ];
                            },
                            onSelected: (String value) async {
                              if (value == 'delete') {
                                deleteItem(index);
                              } else if (value == 'share') {
                                ShareRecipe.share(data[index]);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Future<void> deleteItem(int index) async {
    var myBox = Hive.box('shopping');
    await myBox.deleteAt(index);
  }
}
