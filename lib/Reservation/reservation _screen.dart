import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:findyournewhome/Hostels/hostel_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Hostels/main_page.dart';


class Reservation extends StatefulWidget {
  const Reservation({Key? key,required this.res}) : super(key: key);
final res;
  @override
  State<Reservation> createState() => _ReservationState();
}


class _ReservationState extends State<Reservation> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController type = TextEditingController();


   String Login_id = '';

  //late SharedPreferences _sharedPreferences;

  _loadData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Login_id = prefs.getString('userid') ?? '';
    });
  }
  // _saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('key_string', 'new_value');
  // }
   late int storedId;
  @override
  void initState() {
    super.initState();
    storedId = widget.res.id;
    _loadData();
  }
  doReserve(String name, String email, String phone, String type,) async {
    var res = await widget.res.Reservation(storedId,name,email,phone,type,Login_id);
    print(res.toString());

    if (res["success"]){
      Fluttertoast.showToast(msg: "Reservation Succesfully");
       showAlertDialog( context);
    }else{
      Fluttertoast.showToast(msg: 'Reservation Failed');
    }
  }
   // Declare a variable to store the id
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
          Container(
            color: const Color(0xff0fc1fa),
            height: 100,
            width: double.infinity,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(left: 10),
                child:
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>HostelDetaisl(details: widget.res),

                      ),
                    );
                  },
            child:
                const Icon(Icons.arrow_back_ios,
                color: Colors.white,
                ),
          ),
                ),
                const Padding(padding: EdgeInsets.only(left: 120,),
                child:
                Text('Reservation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(padding: EdgeInsets.only(left: 20),
          child:
          Text('Full Name',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(padding: const EdgeInsets.only(left: 20,right:20),
          child:
          TextFormField(
            controller: name,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Text is empty';
              }
              return null;
            },
            decoration: InputDecoration(
              // labelText: "Your Email",
              hintText: "Enter Name*",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: Theme.of(context).colorScheme.surface,),
              ),
            ),
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(padding: EdgeInsets.only(left:20,right: 20),
          child:
          Text('Email',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(padding: const EdgeInsets.only(left: 20,right: 20),
          child:
          TextFormField(
            controller: email,
            decoration:  InputDecoration(
              hintText: 'Enter Your Email',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.surface,),

            ),
          ),
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(padding: EdgeInsets.only(left: 20),
          child:
          Text('Mobile Phone Number',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20
          ),
          )
          ),
          const SizedBox(
            height: 10,
          ),
        Padding(padding: const EdgeInsets.only(left: 20,right: 20),
          child: TextFormField(
            controller: phone,
            maxLength: 11,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration:  InputDecoration(
              hintText: '03*********',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: Theme.of(context).colorScheme.surface,),

              ),
            ),
          ),
        ),
          const SizedBox(
            height: 10,
          ),
          const Padding(padding: EdgeInsets.only(left: 20),
              child:
              Text('Room Type',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),
              )
          ),
const SizedBox(
  height: 10,
),
          Padding(padding: const EdgeInsets.only(left: 20,right: 20),
          child: TextFormField(
            controller: type,
            maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[1-4]'))
              ],
            decoration:  InputDecoration(
              hintText: '1/2/3/4 Seater',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1, color: Theme.of(context).colorScheme.surface,),

              ),
            ),
          ),
          ),
          Spacer(),
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
                                      vertical: 20.0, horizontal: 50.0),
                                ),
                                foregroundColor: MaterialStateProperty.all<
                                    Color>(Theme.of(context).colorScheme.surface,),
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
                              name.text.isNotEmpty && email.text.isNotEmpty && phone.text.isNotEmpty && type.text.isNotEmpty
                                  ? doReserve(name.text,email.text,phone.text,type.text)
                                  : Fluttertoast.showToast( msg: 'All Fields are required');

                            },
                            child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 14)
                            )
                        ),


                      ],
                    ),
                  ),
                ]
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
      ),
      ),
    );
  }



  }
showAlertDialog(BuildContext context) async {
  // Create button

  Widget okButton =
  Center(
    child:
  ElevatedButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary,),
      backgroundColor: MaterialStateProperty.all<Color>( Theme.of(context).colorScheme.primary,),
    ),
    child: const Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const MyHomePage(),

          ),
        );
      },
  ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    // icon: Icons.account_circle_outlined,
    alignment: Alignment.center,
    icon: const Icon(Icons.check_circle),


    title:
    const Text(

      "Reservation Made Successfully.",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
    ),
    content: const Text("Reservation successfully confirmed for 2 days! Your booking is all set, enjoy your stay!",
      style: TextStyle(
          fontSize: 15
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}