import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Sign_up.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../rest/Login_Api.dart';
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


   late SharedPreferences _sharedPreferences;
  // late SharedPreferences _prefs;
  // String _savedValue = '';
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initSharedPreferences();
  // }
  //
  // Future<void> _initSharedPreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _savedValue = _prefs.getString('textfield_value') ?? '';
  //   });
  // }
  //
  // Future<void> _saveTextFieldValue() async {
  //   await _prefs.setString('textfield_value', email_controller.text);
  //   setState(() {
  //     _savedValue = email_controller.text;
  //   });
  // }

  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body:
        Container(
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
          Image.asset('Assets/logo4.0.png',fit: BoxFit.fill,),
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
              validator: validateEmail,
              decoration:  InputDecoration(
                hintText: 'Enter Your email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface,),

                ),
                prefixIcon: Icon(Icons.email),
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
                prefixIcon: Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
              ),
              obscureText: passwordVisible,


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
         const Spacer(),

         Expanded(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have Account?',),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>const Signup_page(),

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

    _sharedPreferences=await SharedPreferences.getInstance();


    if (res['success']){

      String userEmail=res['user'][0]['email'];
      int userId=res['user'][0]['login_id'];
      print(userId);
      print(userEmail);
      _sharedPreferences.setInt('userid', userId);
      _sharedPreferences.setString('usermail', userEmail);


      Route route= MaterialPageRoute(builder: (_)=> const MyHomePage());
      Navigator.pushReplacement(context, route);

      // await setLoggedIn();
      // Navigator.pushReplacementNamed(context, '/main');
    }else{
      Fluttertoast.showToast(msg: 'Email and password not valid');
    }
  }
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
