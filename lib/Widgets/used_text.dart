import 'package:flutter/material.dart';

class UsedText extends StatelessWidget {
  final String text;
  const UsedText({required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontFamily: 'Poppins', color: Colors.black87,fontSize: 18)
    );
  }
}
