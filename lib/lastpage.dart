import 'package:flutter/material.dart';
import 'dart:io';


class Lastpage extends StatelessWidget {

  File image;
  Lastpage(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Image.file(image),

    );
  }
}
