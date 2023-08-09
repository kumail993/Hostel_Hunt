import 'package:carousel_slider/carousel_slider.dart';
import 'package:findyournewhome/Bottom_navbar/Home.dart';
import 'package:findyournewhome/models/hostels.dart';
import 'package:findyournewhome/Reservation/reservation%20_screen.dart';
import 'package:flutter/material.dart';
class HostelDetaisl extends StatefulWidget {
  const HostelDetaisl({Key? key,required this.details}) : super(key: key);
  final hostels details;
  @override
  State<HostelDetaisl> createState() => _HostelDetaislState();
}

class _HostelDetaislState extends State<HostelDetaisl> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                Image.asset(
                    "Assets/${widget.details.photo}", width: 500, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.asset(
                    "Assets/${widget.details.photo}", width: 400, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.asset(
                    "Assets/${widget.details.photo}", width: 400, fit: BoxFit.fill),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 0,),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child:
                Image.asset(
                    "Assets/${widget.details.photo}", width: 400, fit: BoxFit.fill),
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
        MaterialPageRoute(builder: (context) => const MyHomePage()

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
          Padding(padding: const EdgeInsets.only(left: 10),
          child:
          Text(widget.details.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          )
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(padding: const EdgeInsets.only(left: 10),
              child:
              Text(widget.details.address,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
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
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Row(
              //       children:[
              //         Icon(Icons.bathroom_outlined),
              //         SizedBox(
              //           width: 5,
              //         ),
              //     Text('Attached bath'),
              //     ]
              //     ),
              //     Row(
              //       children:[
              //         Icon(Icons.electric_bolt_outlined),
              //         SizedBox(
              //           width: 5,
              //         ),
              //     Text('Electric backup'),
              //     ]
              //     ),
              //     Row(
              //       children:[
              //         Icon(Icons.set_meal),
              //         SizedBox(
              //           width: 5,
              //         ),
              //     Text('abcd'),
              //         ]
              //     ),
              //   ],
              // )

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
    const Center(
    child: Text(
    'Rooms Prices Plan',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    )),
    FittedBox(
    child:
    DataTable(
    columns: const [
    DataColumn(label: Text(
    'Accommodation',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    )),
    DataColumn(label: Text(
    'OverView',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    )),
    DataColumn(label: Text(
    'Prices-PKR',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    )),
    ], rows: [
      DataRow(
        color: MaterialStateColor.resolveWith((states) {
          // Change the background color of the DataRow based on a specific condition
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return const Color(0xff0fc1fa).withOpacity(0.1);  // Return null to use the default background color
        }),
        cells: const [
      DataCell(Text('1 Seater')),
      DataCell(Text('Stephen')),
      DataCell(Text('22,000')),
      ]),
      DataRow(
        color: MaterialStateColor.resolveWith((states) {
          // Change the background color of the DataRow based on a specific condition
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return const Color(0xff0fc1fa).withOpacity(0.1);  // Return null to use the default background color
        }),
        cells: const [
      DataCell(Text('2 seater')),
      DataCell(Text('Stephen')),
      DataCell(Text('18,000')),
      ]),
      DataRow(
        color: MaterialStateColor.resolveWith((states) {
          // Change the background color of the DataRow based on a specific condition
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return const Color(0xff0fc1fa).withOpacity(0.1);  // Return null to use the default background color
        }),
        cells: const [
      DataCell(Text('3 Seater')),
      DataCell(Text('Stephen')),
      DataCell(Text('15,000')),
      ]),
      DataRow(
        color: MaterialStateColor.resolveWith((states) {
          // Change the background color of the DataRow based on a specific condition
          if (states.contains(MaterialState.selected)) {
            return Colors.green;
          }
          return const Color(0xff0fc1fa).withOpacity(0.1); // Return null to use the default background color
        }),
        cells: const [
      DataCell(Text('4 Seater')),
      DataCell(Text('Stephen')),
      DataCell(Text('12,000')),
      ]),
    ],
    ),
    ),
          Spacer(),
          Expanded(
            flex: 2,
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
                              Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>Reservation(res: widget.details)

                                ),
                              );
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
          ),
          const SizedBox(height: 10,),
    ],
      ),
      ),
    );
  }
}