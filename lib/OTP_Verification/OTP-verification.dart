import 'package:findyournewhome/rest/OTP.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class otp_verification extends StatefulWidget {
  const otp_verification({Key? key}) : super(key: key);

  @override
  State<otp_verification> createState() => _otp_verificationState();
}

class _otp_verificationState extends State<otp_verification> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
          child:Column(
            children: [
              Text("Enter Verification OTP"),
              SizedBox(height: 20,),
              TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                controller: otp,
                decoration:  InputDecoration(
                  hintText: 'Enter you otp',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1, color: Theme.of(context).colorScheme.surface,),

                  ),
                ),

              ),
              SizedBox(height: 20,),

              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 70.0),
                        ),
                        foregroundColor: MaterialStateProperty.all<
                            Color>(Theme.of(context).colorScheme.secondary,),
                        backgroundColor: MaterialStateProperty.all<
                            Color>( Theme.of(context).colorScheme.primary,),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side:  BorderSide(color: Theme.of(context).colorScheme.secondary,),
                              borderRadius: BorderRadius.circular(
                                  18.0),
                            )
                        )
                    ),
                    onPressed: () {
                      otp.text.isNotEmpty
                          ? SendOtp(otp.text)
                          : Fluttertoast.showToast(msg: "All fields required");
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 14),
                    )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  SendOtp(String otp) async {

    var res = await OTP(otp.trim());
    print(res);
  }
}
