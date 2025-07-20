import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: isWide ? 400 : double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Enter Username",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'e.g. gaurang_123',
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text.trim();
                      if (username.isNotEmpty) {

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter a username")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Join Chat",
                      style: TextStyle(fontSize: 16,color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
