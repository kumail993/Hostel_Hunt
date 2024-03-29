import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../OTP_Verification/OTP-verification.dart';
import '../../rest/Sign_up.dart';
class Signup_page extends StatefulWidget {
  const Signup_page({Key? key}) : super(key: key);

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

  doRegister(String name,String username, String email, String password) async {

    var res = await userRegister(name,username, email, password);
    print(res.toString());

    if (res['success']){
      Fluttertoast.showToast(msg: "Registered Succesfully");
      Route route= MaterialPageRoute(builder: (_)=> otp_verification(emails: email,));
      Navigator.pushReplacement(context, route);
    }else{
      Fluttertoast.showToast(msg: 'Email or name Already Exist');
    }
  }

  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Container(
        height: screenHeight,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/background5.0.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child:
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

    child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(child: Column(
                children:[
                  SizedBox(
                    height: 150,
                    width: 150,
                    child:
                    Image.asset('Assets/logo4.0.png',fit: BoxFit.fill,),
                  ),
                  const Text('Create an Account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]
            ),
            ),
            const SizedBox(
              height: 20,
            ),
             Padding(padding: const EdgeInsets.only(left: 50,right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: name,
                      decoration:  InputDecoration(
                        hintText: 'Enter Your Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1, color: Theme.of(context).colorScheme.surface,),

                        ),
                        prefixIcon: Icon(Icons.supervised_user_circle)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Username',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: username,
                      decoration:  InputDecoration(
                          hintText: 'Enter Username',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Theme.of(context).colorScheme.surface,),

                          ),
                          prefixIcon: Icon(Icons.supervised_user_circle)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      validator: validateEmail,
                      decoration:  InputDecoration(
                        hintText: 'Enter Your Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1, color: Theme.of(context).colorScheme.surface,),

                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(
                            passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a password";
                        } else {
                          // Call a function to check password
                          bool result = validatePassword(value);
                          if (result) {
                            // Password is valid
                            return null;
                          } else {
                            // Password is invalid
                            return "Password should contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
                          }
                        }
                      },
                    )

                  ],
                )
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 1,
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    FittedBox(

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 100.0),
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

                                if (_formKey.currentState!.validate()) {
                // Form data is valid, proceed with submission
                                doRegister(name.text,username.text,email.text,password.text);
                                 }
                              },
                              child: const Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 20)
                              )
                          ),


                        ],
                      ),
                    ),
                  ]
              ),
            ),
            // Center(
            //   child: ElevatedButton(
            //
            //       style: ButtonStyle(
            //           padding: MaterialStateProperty.all(
            //             const EdgeInsets.symmetric(
            //                 vertical: 20.0, horizontal: 50.0),
            //           ),
            //           foregroundColor: MaterialStateProperty.all<
            //               Color>(Theme.of(context).colorScheme.secondary,),
            //           backgroundColor: MaterialStateProperty.all<
            //               Color>( Theme.of(context).colorScheme.primary,),
            //           shape: MaterialStateProperty.all<
            //               RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 side:  BorderSide(color: Theme.of(context).colorScheme.secondary,),
            //                 borderRadius: BorderRadius.circular(
            //                     18.0),
            //               )
            //           )
            //       ),
            //       onPressed: () {
            //           if (_formKey.currentState!.validate()) {
            //             // Form data is valid, proceed with submission
            //             doRegister(name.text,email.text,password.text);
            //           }
            //           // name.text.isNotEmpty && email.text.isNotEmpty && password.text.isNotEmpty
            //           //     ? doRegister(name.text,email.text,password.text)
            //           //     : Fluttertoast.showToast( msg: 'All Fields are required');
            //       },
            //
            //       child: const Text(
            //         "Sign Up",
            //         style: TextStyle(fontSize: 14),
            //       )
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account'),
                TextButton(onPressed:  (){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>const LoginPage(),

                ),
                );
                },
                    child:  Text('Sign in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    ))
              ],
            )
          ],
        ) ,
      ),
      ),
      );
  }
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

}
