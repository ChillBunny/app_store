import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categorylable = [
    'food',
    'vegetable',
    'egg',
    'tea',
    'test1',
    'test2',
    'test3'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 19),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categorylable.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ActionChip(
                              backgroundColor: Colors.blueAccent,
                              onPressed: () {},
                              label: Text(
                                _categorylable[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }))),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
          )
        ],
      ),
    );
  }
}
