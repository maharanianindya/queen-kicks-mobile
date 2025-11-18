import 'package:flutter/material.dart';
import 'package:queen_kicks/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:queen_kicks/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "jersey"; // default
  String _thumbnail = "";
  bool _isFeatured = false; // default

  final List<String> _categories = [
    'jersey',
    'footwear',
    'apparel',
    'accessories',
  ];

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
      return Scaffold(
  appBar: AppBar(
    title: const Center(
      child: Text(
        'Add Product Form',
      ),
    ),
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
  ),
  drawer: const LeftDrawer(),
  body: Form(
     key: _formKey,
     child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
  children:[
    // === Name ===
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Product Name",
          labelText: "Product Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _name = value ?? "";
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Name cannot be empty!";
          }
          if (value.length > 255) {
            return "Name cannot be longer than 255 characters.";
          }
          return null;
        },
      ),
    ),
    // === Description ===
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Product Description",
        labelText: "Product Description",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          _description = value ?? "";
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Description cannot be empty!";
        }
        return null;
      },
    ),
  ),

  // === Price ===
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Product Price",
          labelText: "Product Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            _price = int.tryParse(value ?? '') ?? 0;
          });
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Price cannot be empty!";
          }
          final parsed = int.tryParse(value);
          if (parsed == null) {
            return "Price must be a valid number!";
          }
          if (parsed <= 0) {
            return "Price must be greater than 0.";
          } 
          return null;
        },
      ),
    ),

  // === Category ===
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      value: _category,
      items: _categories
          .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat[0].toUpperCase() + cat.substring(1)),
              ))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          _category = newValue!;
        });
      },
    ),
  ),

  // === Thumbnail URL ===
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: "Thumbnail URL",
        labelText: "Thumbnail URL",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          _thumbnail = value ?? "";
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Thumbnail URL cannot be empty!";
        }
        return null; 
      },
    ),
  ),

  // === Is Featured ===
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: SwitchListTile(
      title: const Text("Mark as Featured Product"),
      value: _isFeatured,
      onChanged: (bool value) {
        setState(() {
          _isFeatured = value;
        });
      },
    ),
  ),
  // === Save Button ===
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.indigo),
          ),
          onPressed: () async {
  if (_formKey.currentState!.validate()) {
    // TODO: Replace the URL with your app's URL
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
    // If you using chrome,  use URL http://localhost:8000
    
    final response = await request.postJson(
      "http://localhost:8000/create-flutter/",
      jsonEncode({
        "name": _name,
        "description": _description,
        "thumbnail": _thumbnail,
        "category": _category,
        "price": _price,
        "is_featured": _isFeatured,
      }),
    );
    if (context.mounted) {
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
          content: Text("Product successfully saved!"),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
          content: Text("Something went wrong, please try again."),
        ));
      }
    }
  }
},
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  ],
  ),
  ),
  ));
  }
}

