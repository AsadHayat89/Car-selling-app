import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mjcars/mycolors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  TextEditingController ammoutnText=new TextEditingController();
  TextEditingController ConfirmammoutnText=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Payment",
                  style: TextStyle(
                      color: myColor, fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15,left: 20,right: 20),
                child: TextField(
                  controller: ammoutnText,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: myColor),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    hintText: 'Enter Amount',
                    hintStyle: TextStyle(color: myColor),
                    labelStyle: TextStyle(color: myColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15,left: 20,right: 20),
                child: TextField(
                  controller: ConfirmammoutnText,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: myColor),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Amount',
                    hintText: 'Enter Comfirm Amount',
                    hintStyle: TextStyle(color: myColor),
                    labelStyle: TextStyle(color: myColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:40,right: 10),
                child: GestureDetector(
                  onTap: () async {
                    int ammount1=int.parse(ammoutnText.text);
                    int ammount2=int.parse(ConfirmammoutnText.text);
                    if(ammount1==ammount2){
                      await makePayment(ammoutnText.text);
                    }

                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Text("Pay",style: TextStyle(color: Colors.white,fontSize: 18),)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String ammount) async {
    try {
      paymentIntent = await createPaymentIntent(ammount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51M2TlrIyZcrUZatMeCCJJ2zu71hW6xXnmIxph9jkUMXsbaS95fU17u5yTQsbspJZFf9EFjxBR93ZxMFOyStaY2EL00THiX7PAQ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
