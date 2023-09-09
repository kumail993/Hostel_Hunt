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
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      // Once Login_id is loaded, call fetchReservations
      fetchReservations(Login_id);
      _scrollController.addListener(() {
        // Calculate the maximum scroll extent
        double maxScroll = _scrollController.position.maxScrollExtent;
        // Calculate the current scroll position
        double currentScroll = _scrollController.position.pixels;
        double threshold = 100.0;
        // Check if the user tries to scroll past the last tile
        if (currentScroll > maxScroll-threshold) {
          // If so, set the scroll position to the maximum to stop scrolling
          _scrollController.jumpTo(maxScroll);
        }
      });
    });
    // _loadData();
    // // Replace 'your_login_id' with the actual login ID
    // fetchReservations(Login_id);
  }

  @override
  void dispose() {
    // Dispose of the ScrollController when it's no longer needed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title:  Center(child:Text('Reservation List',
        style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        )),
        )),
      body:
          reservations.isEmpty
      ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: ClipOval(
              child: Opacity(
                opacity: 0.7, // Adjust the opacity value as needed
                child: Image.asset(
                  "Assets/EmptyReservation.gif",
                  fit: BoxFit.cover,
                  width: 200.0, // Set the width to your desired size
                  height: 200.0,
                ),
              ),
            ),
          )

         :
          ListView.builder(
            shrinkWrap: false,
            //physics: NeverScrollableScrollPhysics(),
            //controller: _scrollController,
            //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            itemCount: reservations.length,
            itemBuilder: (BuildContext context, int index) {
              final reversedIndex = reservations.length - 1 - index;
              final reservation = reservations[reversedIndex];
              count = index;
              count++;
                return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child:
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
                       Divider(
                        thickness: 2,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  )
                  );
              }
          ),

    );
  }
}


