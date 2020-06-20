import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';


const request = "https://api.hgbrasil.com/finance?key=a047fb68";

void main() async {

  http.Response response = await http.get(request);
  print(json.decode(response.body)["results"]["currencies"]);

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        backgroundColor: Color(0xff8A2BE2),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffD8BFD8),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0 , 10.0, 0.0),

      ),
    );
  }
}

