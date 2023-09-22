import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Sign_up.dart';
import 'package:findyournewhome/UserAuthentication/Screens/forgot_password.dart';
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
  final TextEditingController username_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();


  late SharedPreferences _sharedPreferences;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  bool isLoading = false; // Add this line to define isLoading
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/background5.0.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5
          ),
        ),
        child:
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:
          Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child:
                      Image.asset('Assets/logo4.0.png', fit: BoxFit.fill,),
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
              Padding(padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        controller: username_controller,
                        //validator: validateEmail,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Theme
                                .of(context)
                                .colorScheme
                                .surface,),

                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                        controller: password_controller,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Theme
                                .of(context)
                                .colorScheme
                                .surface,),

                          ),
                          prefixIcon: const Icon(Icons.lock),
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

              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          isLoading // Check the loading state
                              ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                          )
                          : ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 100.0,
                                ),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                isLoading =
                                true; // Set loading to true when button is pressed
                              });

                              if (username_controller.text.isNotEmpty &&
                                  password_controller.text.isNotEmpty) {
                                await dologin(
                                  username_controller.text,
                                  password_controller.text,
                                );

                                setState(() {
                                  isLoading =
                                  false; // Set loading to false after response is received
                                });
                              } else {
                                setState(() {
                                  isLoading =
                                  false; // Set loading to false if fields are empty
                                });
                                Fluttertoast.showToast(
                                    msg: "All fields required");
                              }
                            },
                            child: // Show loader if loading is true
                                 const Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

               Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (
                            context) => ForgotPasswordScreen(),

                        ),
                      );
                    },

                    child: Text('Forgot Password?'))
              ),
              const Spacer(),

              Expanded(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have Account?',),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (
                          context) => const Signup_page(),

                      ),
                    );
                  }, child: Text('Create Account',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                  ))
                ],
              )
              ),
            ],
          ),
        ),
      ),
    );
  }

//
  // Modified dologin function
  Future<void> dologin(String email, String password) async {
    final res = await userlogin(email.trim(), password.trim());

    if (res['success']) {
      final userEmail = res['res']['user'][0]['user_login'];
      final userId = res['res']['user'][0]['ID'];
      print(userId);
      print(userEmail);
      _sharedPreferences = await SharedPreferences.getInstance();

      _sharedPreferences.setInt('userid', userId);
      _sharedPreferences.setString('usermail', userEmail);

      Route route = MaterialPageRoute(builder: (_) => const home_page());
      Navigator.pushReplacement(context, route);
    }
    else{
      final error = res['error'];
      Fluttertoast.showToast(msg: "Login failed: $error");
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
}
