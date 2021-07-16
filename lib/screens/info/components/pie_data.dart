import 'package:flutter/material.dart';

class PieData {

  List<Data> data = [
    Data(name: 'Problemas com internet',  color: Colors.blue),
    Data(name: 'Relatórios', color: Colors.lightBlueAccent),
    Data(name: 'Outros', color: Colors.deepPurple),
    Data(name: 'Problemas com telefonia', color: Colors.purple),
    Data(name: 'Manutenção de Software', color: Colors.deepOrange),
    Data(name: 'Manutenção de Equipamentos', color: Colors.red),
    Data(name: 'Login usuário', color: Colors.yellow),
    Data(name: 'Instalação de Equipamentos', color: Colors.green),
    Data(name: 'Instalação de Software', color: Colors.black),
  ];

}

class Data {
  final String name;
  final Color color;

  Data({this.name, this.color});
}