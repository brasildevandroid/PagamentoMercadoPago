import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class TestaPagamentoCartao extends StatefulWidget {

  String idPreferencia;


  TestaPagamentoCartao(this.idPreferencia);

  @override
  _TestaPagamentoCartaoState createState() => _TestaPagamentoCartaoState();
}

const publicKey = "cole sua public Key do Mercado aqui";

class _TestaPagamentoCartaoState extends State<TestaPagamentoCartao> {

  String _platformVersion = 'Unknown';



  @override
  void initState() {
    super.initState();
    initPlatformState();


  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MercadoPagoMobileCheckout.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {

      _platformVersion = platformVersion!;

    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento com cartão de crédito'),
        ),
        body:

        ListView(
          children: <Widget>[
            Column(
              children: <Widget>[

                SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child:
                    Image.asset("assets/images/banner_cartao_credito.jpeg",fit: BoxFit.cover)
                ),
                SizedBox(height: 64.0,)
                ,
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Expanded(child:Text(widget.idPreferencia,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
                      )

                    ],
                  ),
                ),


                SizedBox(height: 16.0,),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 44.0,
                    width: double.infinity,
                    child:
                    ElevatedButton(
                      onPressed: () async {

                        PaymentResult result =
                        await MercadoPagoMobileCheckout.startCheckout(
                          publicKey,
                          widget.idPreferencia,
                        );

                        print(result.toString());

                      },
                      child: Text("Pagar"),
                    ),
                  ),
                ),

                SizedBox(height: 12.0,),


              ],)
          ],
        ),



      ),
    );
  }
}
