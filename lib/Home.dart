import 'dart:ui';
//ultilizando o (as) apenas para nomear a biblioteca
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//importando a biblioteca convert para converter string em objeto JSON
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _exibicao = "resultado";
  /*fazendo uma requisição
   
  1º abre o pubspec.yaml abaixo de cupertino eu escrevo a versão (http: ^0.12.0+1)
  2º depois importo a biblioteca import 'package:http/http.dart'*/

  /*criando um metodo assíncrono(async) que aguarda uma resposta await*/

  _consumoWeb() async {
    String url = "https://viacep.com.br/ws/60455495/json/";
    /*criando uma variável de nome response que é do tipo 
    RESPONSE que é uma classe que está dentro da biblioteca HTTP*/
    http.Response response;
    response = await http.get(url);
    //convertendo string para objeto JSON
    //json.decode(response.body);

    /*convertendo o texto para um objeto JSON e armazenei em um mapa de 
    nome retorno*/
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    setState(() {
      _exibicao = "${logradouro}, ${complemento}, ${bairro}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Serviço Web",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(_exibicao),
              Center(
                child: RaisedButton(
                    color: Colors.black,
                    child: Text("pressione",
                        style: TextStyle(color: Colors.white)),
                    onPressed: _consumoWeb),
              )
            ],
          ),
        ),
      ),
    );
  }
}
