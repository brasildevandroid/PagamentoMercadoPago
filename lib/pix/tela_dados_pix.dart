import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class TelaDadosPix extends StatefulWidget {

  Map<String,dynamic> dadosPix;

  TelaDadosPix(this.dadosPix);

  @override
  _TelaDadosPixState createState() => _TelaDadosPixState();
}

class _TelaDadosPixState extends State<TelaDadosPix> {


  String  statusPix = " ";

  Future<void> pesquisaStatusPix() async{


    var url = Uri.parse('http://192.168.1.2:8080/transacao_pix/api/consulta_pix');
    var response = await http.post(url, body: {'idPix': widget.dadosPix["idPIX"]});
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    statusPix = response.body;
    print(statusPix);


  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pesquisaStatusPix();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[

              SizedBox(
                  width: double.infinity,
                  height: 200.0,
                  child:
                  Image.asset("assets/images/img_pix.jpeg",fit: BoxFit.cover)
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Text("Status do Pagamento Pix:",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),

                    Text(widget.dadosPix["status"],style: TextStyle(fontSize: 18.0,color: Colors.green)),

                    SizedBox(height: 16.0,),

                    Text(widget.dadosPix["total_a_pagar"].toString(),style: TextStyle(fontSize: 25.0,color: Colors.green))

                  ],
                ),
              ),

              Padding(padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Image.asset("assets/images/um.png",)),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(child: Text("Abra o app do seu banco ou seu app de pagamentos.",
                        style: TextStyle(fontSize: 18.0,color: Colors.black)))

                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              Padding(padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Image.asset("assets/images/dois.png",)),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(child: Text("Busque á opção de pagar com pix.",style: TextStyle(fontSize: 18.0,color: Colors.black)))

                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              Padding(padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Image.asset("assets/images/tres.png",)),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(child: Text("Copie e cole o seguinte código.",style: TextStyle(fontSize: 18.0,color: Colors.black)))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(widget.dadosPix["qr_code"],
                          style: TextStyle(fontSize: 14.0),)),

                  ),
                ),
              ),

              SizedBox(height: 16.0,),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 44.0,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: (){

                      final data = ClipboardData(text:widget.dadosPix["qr_code"]);
                      Clipboard.setData(data);


                      // Navigator.of(context).push(
                      //    MaterialPageRoute(builder: (context)=>TelaPedidoConfirmado())

                      // );
                    },
                    child: Text("COPIAR CHAVE",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 12.0,),

            ],)
        ],
      ),
    );
  }
}




