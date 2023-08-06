import 'package:findyournewhome/Home.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Sign_up.dart';
import 'package:findyournewhome/rest/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("Assets/Background.jpg"),
    fit: BoxFit.cover,
    ),
    ),
    child:
    Form(
      key: _formKey,
    child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Center(child: Column(
          children:[
        SizedBox(
          height: 200,
          width: 200,
          child:
          Image.asset('Assets/logo.png',fit: BoxFit.fill,),
        ),
         const Text('Login',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Please Sign in to continue'),
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
            const Text('Email',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email_controller,
              decoration:  InputDecoration(
                hintText: 'Enter Your email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface,),

                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Password',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: password_controller,
              decoration:  InputDecoration(
                hintText: 'Enter Your Password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface,),

                ),
              ),
              obscureText: true,


            )
          ],
        )
        ),
        const SizedBox(
          height: 50,
        ),
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
                email_controller.text.isNotEmpty && password_controller.text.isNotEmpty
                    ? dologin(email_controller.text,password_controller.text)
                    : Fluttertoast.showToast(msg: "All fields required");
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 14),
              )
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        
        const Center(
          child: Text('Forgot Password?'),
        ),

         Expanded(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have Account?',),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>Signup_page(),

                  ),
                );
              }, child: const Text('Sign up'))
            ],
          )
        ),
      ],
    ) ,
    ),
        ),
    );
  }

  dologin(String email, String password) async {

    var res = await userlogin(email.trim(), password.trim());

    // String userEmail = res['user'][0]['email'];
    // String userId = res['user'][0]['id'];


    if (res['success']){
      Route route= MaterialPageRoute(builder: (_)=> MyHomePage());
      Navigator.pushReplacement(context, route);
    }else{
      Fluttertoast.showToast(msg: 'Email and password not valid');
    }
  }
}
