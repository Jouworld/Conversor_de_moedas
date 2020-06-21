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
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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


  TextEditingController reaisController = TextEditingController(); //controlador para o recebimento do valor de reais
  TextEditingController dolarController = TextEditingController(); //controlador para o recebimento do valor de dolares
  TextEditingController euroController = TextEditingController(); //controlador para o recebimento do valor de euros
  TextEditingController libraeController = TextEditingController(); //controlador para o recebimento do valor de libras esterlina
  TextEditingController pesoController = TextEditingController(); //controlador para o recebimento do valor de pesos
  TextEditingController bitcoinController = TextEditingController(); //controlador para o recebimento do valor de bitcoins

    double dolar, euro, librae, peso, bitcoin;

    void _realChanged(String text){

        double real = double.parse(text); // tranformando o valor puxado em um double
        dolarController.text = (real/dolar).toStringAsFixed(2); // tranformando o resultado em uma string e mostrar apenas 2 casas decimais
        euroController.text = (real/euro).toStringAsFixed(2);
        libraeController.text = (real/librae).toStringAsFixed(2);
        pesoController.text = (real*peso).toStringAsFixed(2);
        bitcoinController.text = (real/bitcoin).toStringAsFixed(2);


    }
  void _dolarChanged(String text){

    double dolar = double.parse(text);
    reaisController.text = (dolar * this.dolar).toStringAsFixed(2); //pegando o valor digitado e multiplicando pelo valor do dolar o resulta será em reais
    euroController.text = (dolar * this.dolar /euro).toStringAsFixed(2);
    libraeController.text = (dolar * this.dolar /librae).toStringAsFixed(2);
    pesoController.text = (dolar * this.dolar / peso).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar /bitcoin).toStringAsFixed(2);
  }
  void _euroChanged(String text){

    double euro = double.parse(text);
    reaisController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro/dolar).toStringAsFixed(2);
    libraeController.text = (euro * this.euro /librae).toStringAsFixed(2);
    pesoController.text = (euro * this.euro /peso).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro /bitcoin).toStringAsFixed(2);

  }
  void _libraeChanged(String text){

    double librae = double.parse(text);
    reaisController.text = (librae * this.librae).toStringAsFixed(2);
    dolarController.text = (librae * this.librae/dolar).toStringAsFixed(2);
    euroController.text = (librae * this.librae/euro).toStringAsFixed(2);
    pesoController.text = (librae * this.librae/peso).toStringAsFixed(2);
    bitcoinController.text = (librae * this.librae/bitcoin).toStringAsFixed(2);

  }
  void _pesoChanged(String text){

    double peso = double.parse(text);
    reaisController.text = (peso * this.peso).toStringAsFixed(2);
    dolarController.text = (peso * this.peso*dolar).toStringAsFixed(2);
    euroController.text = (peso * this.peso*euro).toStringAsFixed(2);
    libraeController.text = (peso * this.peso*librae).toStringAsFixed(2);
    bitcoinController.text = (peso * this.peso*bitcoin).toStringAsFixed(2);

  }
  void _bitcoinChanged(String text){

    double bitcoin = double.parse(text);
    reaisController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin/dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin/euro).toStringAsFixed(2);
    libraeController.text = (bitcoin * this.bitcoin/librae).toStringAsFixed(2);
    pesoController.text = (bitcoin * this.bitcoin/peso).toStringAsFixed(2);

  }



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
                  librae = snapshot.data["results"]["currencies"]["GBP"]["buy"];
                  peso = snapshot.data["results"]["currencies"]["ARS"]["buy"];
                  bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                            height: 30.0
                        ), //Posso usar o Divider(), po´rem o espaçamennto é pequeno
                        Icon(Icons.monetization_on, size: 150.0, color: Color(0xffFFD700),),
                        SizedBox(
                            height: 30.0
                        ),
                        buildTextField("Reais", "R\$ ", reaisController, _realChanged),
                        SizedBox(
                          height: 20.0
                        ),
                        buildTextField("Dolar", "\$ ", dolarController,_dolarChanged),
                        SizedBox(
                            height: 20.0
                        ),
                        buildTextField("Euro", "€ ", euroController, _euroChanged),
                        SizedBox(
                            height: 20.0
                        ),
                        buildTextField("Libra Esterlina", "£ ", libraeController, _libraeChanged),
                        SizedBox(
                            height: 20.0
                        ),
                        buildTextField("Peso Argentino", "R\$ ", pesoController, _pesoChanged),
                        SizedBox(
                            height: 20.0
                        ),
                        buildTextField("BitCoin", "₿ ", bitcoinController, _bitcoinChanged),
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

Widget buildTextField( String label, prefix, TextEditingController c, Function f){

  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color:Color(0xff8A2BE2) ),
        border: OutlineInputBorder(),
        prefixText: prefix,
    ),
    style: TextStyle( color: Color(0xff8A2BE2) ),
    onChanged: f,
  );



}

