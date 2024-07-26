import 'package:flutter/material.dart';

class ChatRecipientDetails extends StatelessWidget {
  const ChatRecipientDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.network('https://deleoye.ng/wp-content/uploads/2016/11/Dummy-image.jpg'),
        const SizedBox(height: 20),
        const Text('Display Name', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        const SizedBox(height: 20),
        const Text('User description'),
        const SizedBox(height: 20),
        const Text('Skills')
      ],
    );
  }
}