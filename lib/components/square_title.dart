import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;
  const SquareTitle({super.key,required
   this.imagePath});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.grey[200],border:Border.all(color: Colors.white) ),
      padding: EdgeInsets.all(20),

      child: Image.asset(imagePath,height: 40,),
    );
  }
}