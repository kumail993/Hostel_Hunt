import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter your email to reset your password:'),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Send a request to the Node.js API with the entered email.
                // Handle the API response to display appropriate messages to the user.
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}