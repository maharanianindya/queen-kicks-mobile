import 'package:flutter/material.dart';
import 'package:queen_kicks/models/product_entry.dart';
import 'package:queen_kicks/widgets/left_drawer.dart';
import 'package:queen_kicks/screens/product_detail.dart';
import 'package:queen_kicks/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool onlyMine;

  const ProductEntryListPage({super.key, this.onlyMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // Get all products from Django
    final response = await request.get('http://localhost:8000/json/');

    // Get current logged-in user id from login response
    final dynamic rawId = request.jsonData['id'];
    final int? currentUserId =
        rawId == null ? null : int.tryParse(rawId.toString());

    List<ProductEntry> listProduct = [];

    for (var d in response) {
      if (d != null) {
        final product = ProductEntry.fromJson(d);

        if (!widget.onlyMine) {
          // All Products → no filter
          listProduct.add(product);
        } else {
          // My Products → filter by user
          if (currentUserId != null && product.userId == currentUserId) {
            listProduct.add(product);
          }
        }
      }
    }
    return listProduct;
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.onlyMine ? 'My Products' : 'Product Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'There are no product in Queen Kicks yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => ProductEntryCard(
    product: snapshot.data![index],
    onTap: () {
      // Navigate to product detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: snapshot.data![index],
          ),
        ),
      );
    },
  ),
);
            }
          }
        },
      ),
    );
  }
}