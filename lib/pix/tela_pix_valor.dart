import 'package:currency_text_input_mask/currency_text_input_mask.dart';
import 'package:flutter/material.dart';
import 'package:pagamento_mercado_pago/pix/tela_cria_chave_pix.dart';
import 'package:pagamento_mercado_pago/views/default_button.dart';


class TelaPixValor extends StatefulWidget {
  const TelaPixValor({Key? key}) : super(key: key);

  @override
  _TelaPixValorState createState() => _TelaPixValorState();
}

class _TelaPixValorState extends State<TelaPixValor> {

  String valorPix = " ";
  double valorPixDouble = 0;
  Map<String,dynamic> dadosPix = Map();

  final CurrencyTextInputMaskController edtControllerPreco =
              CurrencyTextInputMaskController();


  // Nessa tela obtemos o valor do pix para poder gerá-lo posteriormente.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      edtControllerPreco.addListener(() {
      valorPix = edtControllerPreco.text;
      valorPixDouble = edtControllerPreco.doubleValue;

      print(valorPix);
      print(valorPixDouble);


      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        title:Text("Pagamento com pix",style: TextStyle(fontSize: 20.0),

        ),
        centerTitle: true,
        
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            SizedBox(height: 24.0,),
            Text(
              "Digite o valor que \n deseja pagar",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),

            SizedBox(height: 24.0,),
            Material(
              child: TextFormField(
                controller: edtControllerPreco,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(

                  labelText: 'valor do pix:',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: Colors.black
                    ),

                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30
                ),


              ),


            ),



            SizedBox(height: 48.0,),

            DefaultButton(
              text: "CONTINUAR",
              press: () {

                //depois de obter o valor digitado pelo usuário o salvamos em um
                // Map e enviamos para a próxima tela.

                  dadosPix = {
                    "valorPixDouble":valorPixDouble,
                    "valorPix":valorPix
                  };

                      print(dadosPix.values);

                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>TelaCriaChavePix(dadosPix)));





              },
            ),


            SizedBox(height: 12.0,),

          ],
        ),
      ));

  }
}
