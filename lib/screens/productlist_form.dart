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
      title: const Text('Add Product'),
      backgroundColor: const Color(0xFFFF1F6D),
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    drawer: const LeftDrawer(),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'List your football faves—cute kits, comfy kicks, and must-have '
                      'accessories—so the Queen Kicks fam can shop your drop.',
                    ),
                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _name = value ?? "";
                          });
                        },
                        validator: (value) {
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _description = value ?? "";
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description cannot be empty!";
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _price = int.tryParse(value ?? '') ?? 0;
                          });
                        },
                        validator: (value) {
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Thumbnail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _thumbnail = value ?? "";
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Thumbnail URL cannot be empty!";
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                                  child: Text(
                                      cat[0].toUpperCase() + cat.substring(1)),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _category = newValue!;
                          });
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isFeatured,
                            onChanged: (value) {
                              setState(() {
                                _isFeatured = value ?? false;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text('Is featured'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
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
                                if (!context.mounted) return;
                                if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Product successfully saved!"),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Something went wrong, please try again."),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Publish Product'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}