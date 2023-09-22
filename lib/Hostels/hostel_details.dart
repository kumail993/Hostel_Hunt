import 'package:carousel_slider/carousel_slider.dart';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:findyournewhome/models/hostels.dart';
import 'package:findyournewhome/Reservation/reservation%20_screen.dart';
import 'package:flutter/material.dart';
import '../contants/navigatortransition.dart';

class HostelDetaisl extends StatefulWidget {
  const HostelDetaisl({Key? key, required this.details,required this.image,required this.address,required this.rent,required this.agent,required this.rooms}) : super(key: key);
  final Hostel details;
  final image;
  final address;
  final rent;
  final agent;
  final rooms;
  @override
  State<HostelDetaisl> createState() => _HostelDetaislState();
}

class _HostelDetaislState extends State<HostelDetaisl> {

  late int storedId;
  late String agentid;
  late String rooms;
  //List<Map<String, dynamic>> roomTypeData = [];

  String removeNumbersSpecialCharsAndTags(String input) {
    // Define a regular expression pattern to match numbers, special characters, and HTML tags.
    RegExp pattern = RegExp(r'<[^>]*>|[0-9!@#\$%^&*()_+{}\[\]:;<>,.?~\\|-]');

    // Use the replaceAll method to remove all characters that match the pattern.
    String result = input.replaceAll(pattern, '');

    return result;
  }

  @override
  void initState() {
    super.initState();
    storedId = widget.details.id;
    agentid = widget.agent;
    rooms = widget.rooms;
    //fetchRent(storedId);
    //fetchRoomTypes(storedId);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/background5.0.jpg"),
          fit: BoxFit.cover,
            opacity: 0.5
        ),
      ),
      child: SingleChildScrollView(
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
      children:[
          CarouselSlider(items: [
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                 Image.network(widget.image, width: 500, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.network(widget.image, width: 500, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.network(widget.image, width: 500, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.network(widget.image, width: 500, fit: BoxFit.fill),
              ),
            ),

          ],
            options: CarouselOptions(
              height: 200.0,
              //enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
          ),
        Positioned(
          top: 20,
    left: 20,
    child:
    InkWell(
    onTap: () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const home_page()

        ),
      );
    },
    child:
    const Icon(Icons.arrow_back_ios,
    size: 30,
    )
        ),
        ),
          ]
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05, // Adjust the horizontal padding based on screen width
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.details.HostelName,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05, // Adjust the font size based on screen width
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  widget.rent,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05, // Adjust the font size based on screen width
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05, // Adjust the horizontal padding based on screen width
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: MediaQuery.of(context).size.width * 0.07, // Adjust the icon size based on screen width
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02, // Adjust the width of the SizedBox based on screen width
                ),
                Expanded(
                  child: Text(
                    widget.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04, // Adjust the text size based on screen width
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Padding(padding: EdgeInsets.only(left: 10,right: 10),
            child:Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Text('Description',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600
          ),
          ),
          ),
          Padding(padding: const EdgeInsets.only(left: 10,right: 10),
              child:
              Text(removeNumbersSpecialCharsAndTags(widget.details.PostContent),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              )
          ),
          const Padding(padding: EdgeInsets.only(left: 10,right: 10),
          child:Divider(
            thickness: 2,
          ),
          ),
          const Padding(padding: EdgeInsets.only(left: 10),
          child:
          Text('Amenities',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          )
          ),

          const Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 20),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:[
                      Icon(Icons.set_meal),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Mess'),

                  ]
                  ),
                  Row(
                    children:[
                      Icon(Icons.wifi),
                      SizedBox(
                        width: 5,
                      ),
                  Text('Wifi'),
                  ]
                  ),
                  Row(
                    children:[
                      Icon(Icons.water_drop_sharp),
                      SizedBox(
                        width: 5,
                      ),
                  Text('Warm Water'),
                      ]
                  ),
                  Row(
                          children:[
                            Icon(Icons.bathroom_outlined),
                            SizedBox(
                              width: 5,
                            ),
                        Text('Attached bath'),
                        ]
                        ),

                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:[
                      Icon(Icons.severe_cold_outlined),
                      SizedBox(
                        width: 5,
                      ),
                  Text('Dispenser'),
                  ]
                  ),
                  Row(
                    children:[
                      Icon(Icons.room_service_outlined),
                      SizedBox(
                        width: 5,
                      ),
                  Text('Room Services'),
                  ]
                  ),
                  Row(
                    children:[
                      Icon(Icons.local_laundry_service_outlined),
                      SizedBox(
                        width: 5,
                      ),
                  Text('Laundary'),
                      ]
                  ),
                  Row(
                          children:[
                            Icon(Icons.electric_bolt_outlined),
                            SizedBox(
                              width: 5,
                            ),
                        Text('Electric backup'),
                        ]
                        ),
                ],
              ),

            ],
          ),
          ),
          const Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child:Divider(
              thickness: 2,
            ),
          ),
    const SizedBox(
      height: 20,
    ),

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
                                      vertical: 15.0, horizontal: 50.0),
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

                              Navigator.of(context).push(FadePageRoute(page: Reservation_Screen(res:widget.details,agent: agentid,rooms: rooms,)));
                              // Navigator.pushReplacement(context,
                              //   MaterialPageRoute(builder: (context) =>Reservation(res: widget.details)
                              //
                              //   ),
                            },
                            child: const Text(
                                "Reserve",
                                style: TextStyle(fontSize: 14)
                            )
                        ),


                      ],
                    ),
                  ),
                ]
            ),
          const SizedBox(height: 10,),
    ],
    )
    ),
      )
      );
  }
}