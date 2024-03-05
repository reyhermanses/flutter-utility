import 'package:flutter/material.dart';

class Hotel extends StatefulWidget {
  const Hotel({super.key});

  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text('Hotel'),
        SizedBox(height: 15),
        Container(child: Text('Unavailable'))
      ],
    ));
  }
}
