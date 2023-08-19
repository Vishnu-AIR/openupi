import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyUPIPaymentScreen(),
    );
  }
}

class MyUPIPaymentScreen extends StatelessWidget {
  Future<void> openUPIAppForPayment({
    required String upiId,
    required String payeeName,
    required double amount,
    String? transactionId,
    String? transactionNote,
  }) async {
    final String url =
        "upi://pay?pa=$upiId&pn=$payeeName&mc=&tid=$transactionId&tr=$transactionNote&tn=$transactionNote&am=$amount&cu=INR";

    if (await launchUrl(Uri.parse(url))) {
      throw 'Could not launch UPI app';
    }
  }

  void _handlePaymentButtonPressed() {
    try {
      openUPIAppForPayment(
        upiId: "9718325800@upi",
        payeeName: "Visshnu",
        amount: 1.0,
        transactionId: "vishnu@me.com",
        transactionNote: "hello other side",
      );
    } catch (error) {
      print("Payment Error: $error");
      // Handle payment error gracefully, show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Click the button to make a payment',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePaymentButtonPressed,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
