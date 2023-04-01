import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChargeDetail extends StatefulWidget {
  const ChargeDetail({super.key});

  @override
  State<ChargeDetail> createState() => _ChargeDetailState();
}

class _ChargeDetailState extends State<ChargeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Car'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
