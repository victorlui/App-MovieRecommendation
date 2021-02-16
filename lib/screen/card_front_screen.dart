import 'package:flutter/material.dart';

class CardFrontScreen extends StatelessWidget {
  const CardFrontScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),color: Colors.grey[400]),
      child: Center(child: 
      Image.asset("assets/img/netflix.png")
      ,),
    );
  }
}