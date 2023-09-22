import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../contants/utils.dart';
import '../models/Reservations.dart';

class ReservationListScreen extends StatefulWidget {
  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  List<dynamic> reservations =[]; // Change to a map
  late int loginId;
  late int count;

  _loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        loginId = prefs.getInt('userid')!;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> fetchReservations(int loginId) async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/Hostel-hunt/webreservations/:$loginId'));

    if (response.statusCode == 200) {
      final List<dynamic> parsedData = jsonDecode(response.body); // Parse as a list
      setState(() {
        // Assuming Reservation.fromJson is defined to handle a single JSON object
        reservations = parsedData.map((jsonData) => Reservation.fromJson(jsonData)).toList(); // Parse each object in the list
      });
    } else {
      throw Exception('Failed to load data');
    }
  }



  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      fetchReservations(loginId);
      _scrollController.addListener(() {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double threshold = 100.0;
        if (currentScroll > maxScroll - threshold) {
          _scrollController.jumpTo(maxScroll);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
            'Reservation List',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      body: reservations.isEmpty
          ? Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
        child: ClipOval(
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              "Assets/EmptyReservation.gif",
              fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
            ),
          ),
        ),
      )
          : ListView.builder(
        shrinkWrap: false,
        itemCount: reservations.length,
        itemBuilder: (BuildContext context, int index) {
          final reversedIndex = reservations.length - 1 - index;
          final reservation = reservations[reversedIndex];
          count = index; // Convert index to int before using it
          // Get reservation by index
          count = index + 1;
          return Column(
            children: [

              ListTile(
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                      leading: Text(
                        '$count',
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
                            ],
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
                            ],
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
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     const Text('Room Type: ',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.w700,
                          //       ),
                          //     ),
                          //     Text(reservation.reservationType),
                          //   ],
                          // ),
                          ]
          ),
          ),
              Divider(
                thickness: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
          ]
          );
    }
    )
    );
  }
}












// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../contants/utils.dart';
// import '../models/Reservations.dart';
//
// class ReservationListScreen extends StatefulWidget {
//   @override
//   _ReservationListScreenState createState() => _ReservationListScreenState();
// }
//
// class _ReservationListScreenState extends State<ReservationListScreen> {
//
//   //Map<String, dynamic> Reservations = {};
//   List<Reservation> reservations = [];
//   late int Login_id;
//   late int count;
//
//   //late SharedPreferences _sharedPreferences;
//
//   _loadData() async {
//
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       setState(() {
//         Login_id = prefs.getInt('userid')!;
//       });
//     } catch (e) {
//       print("Error loading data: $e");
//     }
//   }
//
//   Future<void> fetchReservations(int loginId) async {
//     final response = await http.get(Uri.parse('${Utils.baseUrl}/Hostel-hunt/webreservations/:$loginId'));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> parsedData = jsonDecode(response.body); // Change the type to Map
//       setState(() {
//         reservations = parsedData; // Update Reservations to be a Map
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//
//   }
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData().then((_) {
//       // Once Login_id is loaded, call fetchReservations
//       fetchReservations(Login_id);
//       _scrollController.addListener(() {
//         // Calculate the maximum scroll extent
//         double maxScroll = _scrollController.position.maxScrollExtent;
//         // Calculate the current scroll position
//         double currentScroll = _scrollController.position.pixels;
//         double threshold = 100.0;
//         // Check if the user tries to scroll past the last tile
//         if (currentScroll > maxScroll-threshold) {
//           // If so, set the scroll position to the maximum to stop scrolling
//           _scrollController.jumpTo(maxScroll);
//         }
//       });
//     });
//     // _loadData();
//     // // Replace 'your_login_id' with the actual login ID
//     // fetchReservations(Login_id);
//   }
//
//   @override
//   void dispose() {
//     // Dispose of the ScrollController when it's no longer needed
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       appBar: AppBar(
//         title:  Center(child:Text('Reservation List',
//         style: TextStyle(
//         color: Theme.of(context).colorScheme.secondary,
//         )),
//         )),
//       body:
//           Reservations.isEmpty
//       ? Container(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height * 0.5,
//             alignment: Alignment.center,
//             child: ClipOval(
//               child: Opacity(
//                 opacity: 0.7, // Adjust the opacity value as needed
//                 child: Image.asset(
//                   "Assets/EmptyReservation.gif",
//                   fit: BoxFit.cover,
//                   width: 200.0, // Set the width to your desired size
//                   height: 200.0,
//                 ),
//               ),
//             ),
//           )
//
//          :
//           ListView.builder(
//             shrinkWrap: false,
//             //physics: NeverScrollableScrollPhysics(),
//             //controller: _scrollController,
//             //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
//             itemCount: Reservations.length,
//             itemBuilder: (BuildContext context, int index) {
//               final reversedIndex = Reservations.length - 1 - index;
//               final reservation = Reservations[reversedIndex];
//               count = index;
//               count++;
//                 return SingleChildScrollView(
//                     physics: NeverScrollableScrollPhysics(),
//                     child:
//                   Column(
//
//                     children: [
//                       ListTile(
//                         //title: Text(reservation.hostelName),
//                         leading: Text('$count',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//
//                               const SizedBox(height: 5,),
//                               Row(
//                                   children: [
//                                     const Text('Name: ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(reservation['name']),
//                                   ]
//                               ),
//                               const SizedBox(height: 5,),
//                               Row(
//                                   children: [
//                                     const Text('Email: ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(reservation['email']),
//                                   ]
//                               ),
//                               const SizedBox(height: 5,),
//                               Row(
//                                   children: [
//                                     const Text('Phone Number: ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(reservation['name']),
//                                   ]
//                               ),
//
//                             ]
//                         ),
//                         //trailing: Text(reservation.reservationType),
//                       ),
//                        Divider(
//                         thickness: 2,
//                         color: Theme.of(context).colorScheme.primary,
//                       )
//                     ],
//                   )
//                   );
//               }
//           ),
//
//     );
//   }
// }
//
//
