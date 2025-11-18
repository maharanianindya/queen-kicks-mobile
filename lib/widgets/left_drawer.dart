import 'package:flutter/material.dart';
import 'package:queen_kicks/screens/menu.dart';
import 'package:queen_kicks/screens/productlist_form.dart';
import 'package:queen_kicks/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
              ),
            child: Column(
              children: [
                Text(
                  'Queen Kicks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Padding(padding: EdgeInsets.all(10)),
      Text(
        "Check out the latest Queen Kicks products!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    ],
  ),
),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Redirect to MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add Product'),
            // Redirect to ProductFormPage
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductFormPage()), 
              );
            },
          ),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: const Text('Product List'),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductEntryListPage()),
            );
          },
        ),
       ],
      ),
    );
  }
}