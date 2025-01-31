import 'package:flutter/material.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> _cartItems = [
    CartItem(name: "Crochet Bear",
      price: 19.99,
      imagePath: 'assets/images/bear.png', // Replace with your actual image path
      quantity: 1,
    ),
    CartItem(
      name: "Flower Clip Set",
      price: 15.00,
      imagePath: 'assets/images/flowers.png', // Replace with your actual image path
      quantity: 2,
    ),
  ];

  void _updateCartItemQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _cartItems[index].quantity = newQuantity;
      }
    });
  }

  void _navigateToCheckout() {
    // Calculate total price
    double totalPrice = _calculateTotalPrice();

    // Navigate to CheckoutPage with cart items and total price
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CheckoutPage(cartItems: _cartItems, totalPrice: totalPrice),
      ),
    );
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC), // Light pink background
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFF8BBD0), // Pink app bar
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      item.imagePath,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(color: Color(0xFF4A148C)),
                    ),
                    subtitle: Text(
                      'Price: \$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Color(0xFF4A148C)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove,
                              color: Color(0xFF4A148C)),
                          onPressed: () {
                            _updateCartItemQuantity(
                                index, item.quantity - 1);
                          },
                        ),
                        Text(
                          '${item.quantity}',
                          style: const TextStyle(color: Color(0xFF4A148C)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add,
                              color: Color(0xFF4A148C)),
                          onPressed: () {
                            _updateCartItemQuantity(
                                index, item.quantity + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                ),
                Text(
                  '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF8BBD0),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              textStyle: const TextStyle(fontSize:18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}