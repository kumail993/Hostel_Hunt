import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/navigatortransition.dart';


class Reservation_Screen extends StatefulWidget {
  const Reservation_Screen({Key? key,required this.res,required this.agent,required this.rooms}) : super(key: key);
final res;
final agent;
final rooms;
  //final List<Map<String, dynamic>> roomtype;
  @override
  State<Reservation_Screen> createState() => _Reservation_ScreenState();
}


class _Reservation_ScreenState extends State<Reservation_Screen> {
  final _formKey = GlobalKey<FormState>();
  List<String> roomList=[''];
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  //late final TextEditingController type = TextEditingController();

  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  String fullNumber = '';

    late int Login_id;
    late String rooms;
    late String type;
  bool isLoading = false;
  //String cleanedInput = in.replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");

  //late SharedPreferences _sharedPreferences;

  _loadData() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        Login_id = prefs.getInt('userid')!;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }


   late int storedId;
  late String agentid;
  @override
  void initState() {
    super.initState();
    storedId = widget.res.id;
    agentid = widget.agent;
    rooms = widget.rooms;
    setState(() {
       roomList = rooms.split(',');
    });
    _loadData();
  }
  doReserve(String name, String email, String phone, String type,) async {
    var res = await widget.res.Reservation(storedId,name,email,phone,type,agentid,Login_id);

    if (res["success"]){
       showAlertDialog( context);
    }else{
      Fluttertoast.showToast(msg: 'Reservation Failed');
    }
  }


  String? selectedValue;
   // Declare a variable to store the id
  @override
  Widget build(BuildContext context) {
    print(roomList);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reservations"),
        leading: InkWell(
          onTap: () {
             //Navigator.of(context).push(FadePageRoute(page: HostelDetaisl(details: widget.res, image: null,rooms: null,rent: null, address: null,agent: null,)));
                },

    child:const Icon(Icons.arrow_back_ios),
      ),
      ),
      resizeToAvoidBottomInset: false,
      body:
      Container(
      height: double.maxFinite,
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
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
           Padding(padding: EdgeInsets.only(left: 20),
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
            validator: validateEmail,
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
            child:InternationalPhoneNumberInput(
              maxLength: 12,
              spaceBetweenSelectorAndTextField: 0,
              onInputChanged: (PhoneNumber number) {
                // You can handle input changes here if needed

              },
              onInputValidated: (bool value) {
                // You can handle validation here if needed
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: phone,
              formatInput: true,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              onSaved: (PhoneNumber number) {
                setState(() {
                  String dialCode = number.dialCode ?? ""; // Get the dial code
                  String phoneNumber = number.phoneNumber ?? ""; // Get the phone number
                  fullNumber = dialCode + phoneNumber; // Concatenate them
                  phone.text = fullNumber;
                  print(phone);
                  print('On Saved: $fullNumber');
                });
                // Concatenate dial code and phone number and save it to the controller
                print(phone);
              // Save it to the controller

              },
            )

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
              ),
          ),
const SizedBox(
  height: 10,
),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select Room Type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: roomList.map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )).toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                    type = selectedValue!;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  elevation: 2,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Theme.of(context).colorScheme.primary,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200, // Adjust this value as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  offset: const Offset(-100, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    crossAxisMargin: 130,
                    mainAxisMargin: 120,
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
          ),

          // Padding(padding: const EdgeInsets.only(left: 20,right: 20),
          // child: TextFormField(
          //   controller: type,
          //   maxLength: 1,
          //     keyboardType: TextInputType.number,
          //     inputFormatters: <TextInputFormatter>[
          //       FilteringTextInputFormatter.allow(RegExp(r'[1-4]'))
          //     ],
          //   decoration:  InputDecoration(
          //     hintText: '1/2/3/4 Seater',
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         width: 1, color: Theme.of(context).colorScheme.surface,),
          //
          //     ),
          //   ),
          // ),
          // ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Use a variable to track whether the reservation is in progress
                      isLoading
                          ? CircularProgressIndicator() // Show a loading indicator
                          :
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 50.0,
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        // Disable the button when the reservation is in progress
                        onPressed: isLoading ? null : () {
                          setState(() {
                            isLoading = true; // Set loading to true when the button is pressed
                          });
                          name.text.isNotEmpty && email.text.isNotEmpty && phone.text.isNotEmpty && type.isNotEmpty
                              ? doReserve(name.text, email.text, phone.text, type).then((_) {
                            setState(() {
                              isLoading = false; // Set loading to false when the reservation is done
                            });
                          })
                              : Fluttertoast.showToast(msg: 'All Fields are required');
                        },
                        child:  const Text(
                          "Submit",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10,),
        ],
      ),
      ),
      ),
    );
  }
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'PK');

    setState(() {
      this.number = number;
    });
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
        Navigator.of(context).push(FadePageRoute(page: const home_page()));
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

      "Reservation_Screen Made Successfully.",
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
