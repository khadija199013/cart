import 'package:flutter/material.dart';
import 'cart.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  const CheckoutPage(
      {Key? key, required this.cartItems, required this.totalPrice})
      : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String _errorMessage = '';

  void _placeOrder() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _errorMessage = 'Please enter your name.';
        return;
      }
      if (_emailController.text.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
              .hasMatch(_emailController.text)) {
        _errorMessage = 'Please enter a valid email address.';
        return;
      }
      if (_addressController.text.isEmpty) {
        _errorMessage = 'Please enter your address.';
        return;
      }
      if (_phoneController.text.isEmpty ||
          !RegExp(r"^\d+$").hasMatch(_phoneController.text)) {
        _errorMessage = 'Please enter a valid phone number.';
        return;
      }

      // TODO: Replace this with actual order placement logic
      // - Send order data to your backend (cartItems, totalPrice, user info)
      // - Handle API response (success/failure)
      _errorMessage =
      'Order placed successfully!'; // Replace with actual success message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),// Light pink background
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFFF8BBD0), // Pink app bar
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Billing Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Color(0xFF4A148C)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A148C)),
                ),
              ),
              style: const TextStyle(color: Color(0xFF4A148C)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFF4A148C)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A148C)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Color(0xFF4A148C)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(color: Color(0xFF4A148C)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A148C)),
                ),
              ),
              maxLines: 3, // Allow multiple lines for address input
              style: const TextStyle(color: Color(0xFF4A148C)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Color(0xFF4A148C)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4A148C)),
                ),
              ),
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Color(0xFF4A148C)),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(color: Color(0xFF4A148C)),
                  ),
                  subtitle: Text(
                    'Quantity: ${item.quantity} - Price: \$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Color(0xFF4A148C)),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                ),
                Text(
                  '\$${widget.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8BBD0),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

