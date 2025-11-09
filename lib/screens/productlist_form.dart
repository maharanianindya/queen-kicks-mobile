import 'package:flutter/material.dart';
import 'package:queen_kicks/widgets/left_drawer.dart';

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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Product saved successfully'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text('Name: $_name'),
                          Text('Description: $_description'),
                          Text('Category: $_category'),
                          Text('Price: $_price'),
                          Text('Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
                          Text('Featured: ${_isFeatured ? "Yes" : "No"}'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                           _formKey.currentState!.reset();
                        },
                      ),
                    ],
                  );
                },
              );
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

