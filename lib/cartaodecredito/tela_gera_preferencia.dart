import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagamento_mercado_pago/cartaodecredito/testa_pagamento_cartao.dart';

class TelaGeraPreferencia extends StatefulWidget {

  TelaGeraPreferencia();

  @override
  _TelaCriaPIXState createState() => _TelaCriaPIXState();
}

class _TelaCriaPIXState extends State<TelaGeraPreferencia> {


  String idPreferencia = " ";

  Future<void> gerarPreferencia() async{

    var url = Uri.parse('http://192.168.1.2:8080/transacao_pix/api/gerar_preferencia');


    var response = await http.post(url, body: {

      'nome':"Luiz",
      "sobrenome":"Pinheiro de Jesus",
      "email":"luizcox1@hotmail.com",
      "cidade":"Rio de Janeiro",
      "bairro":"campo grande",
      "numero":"800",
      "rua":"Rua agenor Miranda",
       "cep":"23065615",
      "estado":"RJ",
       "ddd":"21",
      "celular":"998435055",
       "cpf":"07272608633",
      "valor":"3000.0"});

    print('Response status: ${response.statusCode}');
    print('Response body:   ${response.body}');


    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("o codigo é 200");


      Map<String,dynamic> resultado = json.decode(response.body);

      print(resultado['id']);


        idPreferencia = resultado['id'];


      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TestaPagamentoCartao(idPreferencia)));

    } else {

      throw Exception('Failed to payment card');
    }


  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      gerarPreferencia();


  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Mercado Pago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento com cartão de crédito'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        ),
      ),
    );
  }
}


