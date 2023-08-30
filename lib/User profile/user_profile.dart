
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/utils.dart';
class Reservation {
  final int reservationId;
  final String reservationName;
  final String reservationEmail;
  final String reservationPhone;
  //final int reservationType;
  final String hostelName;

  Reservation({
    required this.reservationId,
    required this.reservationName,
    required this.reservationEmail,
    required this.reservationPhone,
    //required this.reservationType,
    required this.hostelName,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservation_id'],
      reservationName: json['name'],
      reservationEmail: json['email'],
      reservationPhone: json['ph_no'],
      //reservationType: json['type'],
      hostelName: json['hostel_name'],
    );
  }
}

class ReservationListScreen extends StatefulWidget {
  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  List<Reservation> reservations = [];
  late int Login_id;
  late int count;

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

  Future<void> fetchReservations(int loginId) async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/Hostel-hunt/reservations/:$loginId'));
    //print(loginId);

    if (mounted) { // Check if the widget is still mounted before updating state
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        //print(jsonData);
        setState(() {
          reservations = jsonData.map((data) => Reservation.fromJson(data)).toList();
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      // Once Login_id is loaded, call fetchReservations
      fetchReservations(Login_id);
    });
    // _loadData();
    // // Replace 'your_login_id' with the actual login ID
    // fetchReservations(Login_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:Text('Reservation List')),
      ),
      body:
      ListView.builder(
        shrinkWrap: true,
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reversedIndex = reservations.length - 1 - index;
          final reservation = reservations[reversedIndex];
          count = index;
          count++;
          if(reversedIndex<0){
            return const Center(child: Text("No result Found"));
          }
          else {
            return
              Column(

                children: [
                  ListTile(
                    title: Text(reservation.hostelName),

                    leading: Text('$count',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          const SizedBox(height: 5,),
                          Row(
                              children: [
                                const Text('Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(reservation.reservationName),
                              ]
                          ),
                          const SizedBox(height: 5,),
                          Row(
                              children: [
                                const Text('Email: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(reservation.reservationEmail),
                              ]
                          ),
                          const SizedBox(height: 5,),
                          Row(
                              children: [
                                const Text('Phone Number: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(reservation.reservationPhone),
                              ]
                          ),

                        ]
                    ),
                    //trailing: Text(reservation.reservationType),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color(0xff0fc1fa),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// import '../Bottom_navbar/Home.dart';
// class profile extends StatefulWidget {
//   const profile({Key? key,}) : super(key: key);
//
//   @override
//   State<profile> createState() => _profileState();
// }
//
// class _profileState extends State<profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: const BoxDecoration(
//         image: DecorationImage(
//         image: AssetImage("Assets/Background.jpg"),
//     fit: BoxFit.cover,
//     ),
//     ),
//         child: Column(
//           children: [
//             Container(
//               color: const Color(0xff0fc1fa),
//               height: 50,
//               width: double.infinity,
//               child:  Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(padding: const EdgeInsets.only(left: 10),
//                     child:
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) =>const MyHomePage(),
//
//                           ),
//                         );
//                       },
//                       child:
//                       const Icon(Icons.arrow_back_ios,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const Padding(padding: EdgeInsets.only(left: 120,),
//                     child:
//                     Text('User Profile',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             CircleAvatar(
//               //minRadius: 20,
//               //maxRadius: 80,
//               radius: 80.0,
//               backgroundColor: Colors.grey,
//               foregroundColor: Colors.black,
//               child:
//                   SizedBox(
//                     height: 200,
//                     width: 200,
//                     child:
//               ClipOval(
//                 child:
//               Image.asset('Assets/5.jpg',fit: BoxFit.fill,),
//             ),
//             ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Kumail Haider Sangi'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Padding(padding: EdgeInsets.only(left: 20,right: 20),
//             child: Divider(
//               thickness: 2,
//             )
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const ListTile(
//               leading: Icon(Icons.email_outlined),
//               title: Text('khaider308@gmail.com',
//             ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Padding(padding: EdgeInsets.only(left: 20,right: 20),
//                 child: Divider(
//                   thickness: 2,
//                 )
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const ListTile(
//               leading: Icon(Icons.location_city_outlined),
//               title: Text('Islamabad'),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Padding(padding: EdgeInsets.only(left: 20,right: 20),
//                 child: Divider(
//                   thickness: 2,
//                 ),
//             ),
//       ]
//     )
//     )
//     );
//   }
// }
