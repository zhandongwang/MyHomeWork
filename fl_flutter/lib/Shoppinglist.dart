import 'package:fl_flutter/ShoplistItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Shoppinglist extends StatefulWidget {
  final List<Product> products;

  Shoppinglist({Key key, this.products}):super(key:key);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ShoppingListState();
  }
}

class _ShoppingListState extends State<Shoppinglist> {
  Set<Product> _shoppingCart = new Set<Product>();
  
  void _handleCartChanged(Product product, bool inCart){
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Shopping list'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 0.0),

        children: widget.products.map(
          (Product product){
            return new ShoppingListItem(
              product: product,
              inCart: _shoppingCart.contains(product),
              onCartChanged: _handleCartChanged,
            );
          }).toList(),
      ),
    );
  }

  
}