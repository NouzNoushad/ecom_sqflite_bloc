import 'package:flutter/material.dart';
import 'package:flutter_cubit_sqflite/colors.dart';
import 'package:flutter_cubit_sqflite/screens/modules/cart_lists.dart';
import 'package:flutter_cubit_sqflite/screens/modules/home_lists.dart';

class EcomHome extends StatelessWidget {
  const EcomHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Ecom App using Bloc'),
          centerTitle: true,
          backgroundColor: CustomColors.primaryColor,
          bottom: const TabBar(
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.transparent,
              tabs: [Icon(Icons.home), Icon(Icons.shopping_cart)]),
        ),
        body: const TabBarView(children: [
          HomeList(),
          CartList(),
        ]),
      ),
    );
  }
}
