
import 'package:flutter/material.dart';

class PieData {
  List<Data> data = [
    Data(name: 'Blue', percent: 10, color: const Color(0xff0293ee)),
    Data(name: 'Orange', percent: 5, color: const Color(0xfff8b250)),
    Data(name: 'Black', percent: 1, color: Colors.black),
    Data(name: 'Green', percent: 1, color: Colors.yellow),
    Data(name: 'Green', percent: 1, color: Colors.redAccent),
    Data(name: 'Green', percent: 1, color: Colors.purple),
    Data(name: 'Green', percent: 1, color: Colors.deepOrange),
    Data(name: 'Green', percent: 1, color: Colors.blueAccent),
    Data(name: 'Green', percent: 1, color: Colors.lime),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}