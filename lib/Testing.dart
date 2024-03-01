import 'package:flutter/material.dart';

class MyHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  color: Colors.red,
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  color: Colors.red,
                  width: 150.0,
                  height: 150.0,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
