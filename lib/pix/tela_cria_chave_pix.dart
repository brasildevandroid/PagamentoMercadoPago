import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagamento_mercado_pago/pix/tela_dados_pix.dart';

class TelaCriaChavePix extends StatefulWidget {

    Map<String,dynamic> dadosPix;

    TelaCriaChavePix(this.dadosPix);


  @override
  _TelaCriaChavePixState createState() => _TelaCriaChavePixState();
}

class _TelaCriaChavePixState extends State<TelaCriaChavePix> {

  String chavePix = " ";

  Future<void>  criaChavePix() async{

    //é importante ressaltar que você precisa informar o ip da maáquina, como
    // exatamente abaixo,ah e claro não esqueça de startar seu projeto back-end.

    var url = Uri.parse('http://192.168.1.2:8080/transacao_pix/api/gerar_pix');

    // Apos enviarmos os dados necessários para á criação do pix o mesmo nos
    // retorna um map contendo os dados do pix gerado.

    var response = await http.post(url, body: {
      'nome': "Luiz",
      "sobrenome":"Pinheiro de Jesus",
      "email":"luizcox1@hotmail.com",
      "cidade":"Belford Roxo",
      "bairro":"Nova Aurora",
      "numero":"800",
      "rua":"rua jardineira",
      "cep":"23066800",
      "estado":"RJ",
      "ddd":"21",
      "celular":"998435070",
      "cpf":"07272608630",
      "valor": widget.dadosPix["valorPixDouble"].toString()});


    print('Response status: ${response.statusCode}');
    print('Response body:   ${response.body}');


    if (response.statusCode == 200) {

      print("o codigo é 200");

      //  chavePix = response.body;

      Map<String,dynamic> resultado = json.decode(response.body);

      print(resultado);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TelaDadosPix(resultado)));


    } else {

      throw Exception(response.body);
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    criaChavePix();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      ),
    );


  }


}
