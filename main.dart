import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


const request = "https://api.hgbrasil.com/finance?key=a047fb68";  //chamando a API

void main() async {


  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor:Color(0xff8A2BE2),
        primaryColor: Color(0xff8A2BE2),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0xff8A2BE2))),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Color(0xff8A2BE2))),
          hintStyle: TextStyle(color: Color(0xff8A2BE2)),
        )),
    debugShowCheckedModeBanner: false,
  ));
}

Future<Map> getData() async {

  http.Response response = await http.get(request);
  return json.decode(response.body);

} // Chamando a API em um método futuro  e retornando o corpo do Json em um Mapa

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    double dolar, euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$  Conversor de Moedas  \$"),
        backgroundColor: Color(0xff8A2BE2),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffD8BFD8),
      body: FutureBuilder<Map>( // definindo o corpo do meu corpo como as informações de um mapa
          future: getData(), // chamando o maoa
          builder: (context, snapshot){ // utilizando o método builder para definir como será a construção dos dados conforme são recebidos ou não
            switch(snapshot.connectionState){ // condicional com o snaapshot para dizer como está a conexão
              case ConnectionState.none: //vazia
              case ConnectionState.waiting: // em espera
                return Center(
                  child: Text("Carregando Dados...",
                  style: TextStyle( color: Color(0xff8A2BE2), fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if(snapshot.hasError){ // Erro
                  return Center(
                    child: Text("Erro ao carregar dados!...",
                      style: TextStyle( color: Color(0xff8A2BE2), fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                            height: 40.0
                        ), //Posso usar o Divider(), po´rem o espaçamennto é pequeno
                        Icon(Icons.monetization_on, size: 150.0, color: Color(0xffFFD700),),
                        SizedBox(
                            height: 40.0
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color:Color(0xff8A2BE2) ),
                            border: OutlineInputBorder(),
                            prefixText: "R\$ "
                          ),
                          style: TextStyle( color: Color(0xff8A2BE2) ),
                        ),
                        SizedBox(
                          height: 20.0
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Dolar",
                              labelStyle: TextStyle(color:Color(0xff8A2BE2) ),
                              border: OutlineInputBorder(),
                              prefixText: "US\$ "
                          ),
                          style: TextStyle( color: Color(0xff8A2BE2) ),
                        ),
                        SizedBox(
                            height: 20.0
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Euro",
                              labelStyle: TextStyle(color:Color(0xff8A2BE2) ),
                              border: OutlineInputBorder(),
                              prefixText: "€"
                          ),
                          style: TextStyle( color: Color(0xff8A2BE2) ),
                        )
                      ],
                    )
                  );
                }
            }
          }
      )
    );
  }
}
