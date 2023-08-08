import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:findyournewhome/hostel_details.dart';
import 'package:findyournewhome/rest/rest_api.dart';
import 'package:findyournewhome/user_profile.dart';
import 'package:findyournewhome/util/data_store.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:super_banners/super_banners.dart';
import 'models/cars.dart';
import 'package:http/http.dart' as http;
class home_page extends StatefulWidget {
  const home_page({Key? key,}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late Future<List<hostels>> PremiumhostelData;
  late Future<List<hostels>> RatedhostelData;
  @override
  void initState() {
    super.initState();
    PremiumhostelData = fetchPremiumHostel();
    RatedhostelData = fetchRatedHostel();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          title:  Center(child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 5),
              stopPauseOnTap: true,

              animatedTexts: [
            RotateAnimatedText('Hostel Hunt',),
                RotateAnimatedText('Find Your Hostel'),
          ])
          ),
          // actions: [
          //   Padding(padding: const EdgeInsets.only(right: 10),
          //   child:
          //       InkWell(
          //         child:
          //   const Icon(Icons.search_outlined,),
          //         onTap: () => showSearch(
          //               context: context,
          //               delegate: SearchPage(
          //               //onQueryUpdate: print,
          //               items: Datastore.hos,
          //               searchLabel: 'Search Hostel',
          //               suggestion:
          //               Container(
          //                 height: double.maxFinite,
          //                 width: double.maxFinite,
          //                 decoration: const BoxDecoration(
          //                   image: DecorationImage(
          //                     image: AssetImage("Assets/Background.jpg"),
          //                     fit: BoxFit.cover,
          //                     opacity: 0.6,
          //
          //                   ),
          //                 ),
          //                 child:
          //                Center(
          //               child: Image.asset('Assets/searchgif.gif',height: 200,width: 200,)
          //           ),
          //               ),
          //           failure:
          //           const Center(
          //           child: Text('No Hostel found :('),
          //           ),
          //           filter: (hostels) => [
          //           hostels.name,
          //           //person.surname,
          //           hostels.rent.toString(),
          //           ],
          //           sort: (a, b) => a.compareTo(b),
          //           builder: (hostels) =>
          //               GestureDetector(
          //                 onTap:
          //                     () {
          //                   Navigator.of(context)
          //                       .push(MaterialPageRoute(builder: (context) {
          //                     return HostelDetaisl(details: hostels);
          //                   }));
          //                 },
          //                 child:
          //               Card(
          //             shape: RoundedRectangleBorder(
          //               // side: BorderSide(
          //               //   color: Colors.greenAccent,
          //               // ),
          //               borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
          //             ),
          //             elevation: 10,
          //             child:
          //             Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children:[
          //                       Padding(padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
          //                         child:
          //                         Container(
          //                           width: double.infinity,
          //                           height: 180,
          //                           decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(10),
          //                               shape: BoxShape.rectangle,
          //                               image: DecorationImage(
          //                                   fit: BoxFit.cover,
          //                                   image: AssetImage(hostels.photo)
          //                               )
          //                           ),
          //                         ),
          //                       ),
          //                   Padding(padding: const EdgeInsets.only(left:10,top: 5),
          //                     child:
          //                     Text(
          //                       hostels.name,
          //                       style: const TextStyle(
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.w700,
          //                         color: Colors.black,
          //                       ),
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     height: 2,
          //                   ),
          //                   Padding(padding: const EdgeInsets.only(left:10,),
          //                     child:
          //                     Text(
          //                       hostels.address,
          //                       style: const TextStyle(
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.w100,
          //                       ),
          //                     ),
          //                   ),
          //                 ]
          //             ),
          //           ),
          //               ),
          //           ),
          //   ),
          //   ),
          //   ),
          // ],
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.secondary,

          child:
          ListView(

            children:  <Widget>[
              const SizedBox(
                height:30,
              ),
              const Row(
                  children:[
                    Padding(padding: EdgeInsets.only(left: 30,),
                      child:
                      Column(
                          children:[
                            CircleAvatar(
                              minRadius: 50,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("Assets/logo.png",
                              ),
                            ),

                          ]
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text('Kumail Haider',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,

                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]
                    ),

                  ]
              ),


              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height:20,
              ),
               Padding(padding: const EdgeInsets.only(left: 5,),
                child:
                ListTile(

                  //leading: Icon(Icons.article),
                  title: const Text("Your Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  leading: const Icon(Icons.person),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: (){
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>const profile(),

                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height:30,
              ),
              Padding(padding: const EdgeInsets.only(left: 5,),
                child:
                ListTile(

                  leading: const Icon(Icons.app_registration_outlined),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: const Text("Login/Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,


                    ),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>const LoginPage(),

                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height:30,
              ),
               const Padding(padding: EdgeInsets.only(left: 5,),
                child:
                ListTile(

                  leading: Icon(Icons.portrait),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Text("Portal",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height:30,
              ),
              Padding(padding: const EdgeInsets.only(left: 5,),
                child:
                ListTile(

                  leading: const Icon(Icons.cleaning_services_sharp),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: const Text("Services",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  onTap: (){

                  },
                ),
              ),

              const SizedBox(
                height:30,
              ),
              const ListTile(
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                title: Text("Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),

              ),
            ],
          ),
        ) ,
      body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/Background.jpg"),
          fit: BoxFit.cover,
          opacity: 0.6,

        ),
      ),
      child:

      SingleChildScrollView(
    child:
        Padding(padding: const EdgeInsets.only(bottom: 20),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 10,
          // ),
          Container(
            color: const Color(0xff0fc1fa).withOpacity(0.4),
            height: 250,
            width: double.maxFinite,
            child:CarouselSlider(items: [
              Padding(padding: const EdgeInsets.only(left: 15,right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                  Image.asset(
                      'Assets/splash screen.jpg', width: 500, fit: BoxFit.fill),
                ),
              ),
              Padding(padding: const EdgeInsets.only(left: 15,right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                  Image.asset(
                      'Assets/splash screen.jpg', width: 400, fit: BoxFit.fill),
                ),
              ),
              Padding(padding: const EdgeInsets.only(left:15,right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                  Image.asset(
                      'Assets/splash screen.jpg', width: 400, fit: BoxFit.fill),
                ),
              ),
              Padding(padding: const EdgeInsets.only(left: 15,right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                  Image.asset(
                      'Assets/splash screen.jpg', width: 400, fit: BoxFit.fill),
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
                onPageChanged: (index, reason) {
                      _currentIndex = index;
                      setState((){});
                    },
              ),

            ),
          // CarouselSlider.builder(itemCount:DataStore.p.length,
          //     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          //       hostels paidd = DataStore.p[itemIndex];
          //       return GestureDetector(
          //         child: Padding(padding: const EdgeInsets.only(left: 0,),
          //             child:
          //             Card(
          //               shape: RoundedRectangleBorder(
          //                 // side: BorderSide(
          //                 //   color: Colors.greenAccent,
          //                 // ),
          //                 borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
          //               ),
          //               elevation: 10,
          //               color: Colors.white,
          //               child:
          //               Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Padding(padding: const EdgeInsets.only(
          //                         left: 10, right: 10, top: 10),
          //                       child:
          //                       ClipRRect(
          //                         borderRadius: BorderRadius.circular(10.0),
          //                         child:
          //                         Image.asset(
          //                             paidd.photo, width: 300,
          //                             height: 150,
          //                             fit: BoxFit.fill),
          //                       ),
          //                     ),
          //                     Expanded(child:
          //                     Padding(padding: const EdgeInsets.only(
          //                         left: 20, right: 20, top: 10),
          //                       child:
          //                       Text(paidd.name,
          //                         style: const TextStyle(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                     ),
          //                     ),
          //                   ]
          //               ),
          //             ),
          //           ),
          //         );
          //     },
          //   options: CarouselOptions(
          //     height: 200.0,
          //     enlargeCenterPage: true,
          //     autoPlay: true,
          //     aspectRatio: 16 / 9,
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     enableInfiniteScroll: true,
          //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
          //     viewportFraction: 1,
          //     pageSnapping: true,
          //     padEnds: true,
          //     onPageChanged: (index, reason) {
          //       _currentIndex = index;
          //       setState((){});
          //     },
          //   ), ),
          ),
          Center(child:
          DotsIndicator(
            dotsCount:4,
            position: _currentIndex,
            decorator: const DotsDecorator(
              color: Colors.grey,
              activeColor: Color(0xff0fc1fa),
            ),
          ),
          ),

                    const SizedBox(
                      height: 5,
                    ),
          const Padding(padding: EdgeInsets.only(left: 10,right: 10),
            child:
            Divider(
              thickness: 1,
            ),
          ),
           const SizedBox(
             height: 5,
           ),
           const Padding(padding: EdgeInsets.only(left: 20),
           child:
           Text('Categories',
           style: TextStyle(
             fontWeight: FontWeight.w700,
             fontSize: 20,
           ),
           ),
           ),
           const SizedBox(
             height: 10,
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.greenAccent,
                        // ),
                        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                      ),
                      elevation: 20,
                      child:  Icon(Icons.bed_sharp,
                      size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    ),
                SizedBox(
                  height: 50,
                  width: 50,
                  //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child:  Card(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //   color: Colors.greenAccent,
                      // ),
                      borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                    ),
                    elevation: 20,
                    child:  Icon(Icons.add_call,
                    size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child:  Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.greenAccent,
                        // ),
                        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                      ),
                      elevation: 20,

                      child: Icon(Icons.account_balance,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 50,
                    //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child:  Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.greenAccent,
                        // ),
                        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                      ),
                      elevation: 20,
                      child:  Icon(Icons.account_balance,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  )
              ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    //color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child:  Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //   color: Colors.greenAccent,
                        // ),
                        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                      ),
                      elevation: 20,
                      child: Icon(Icons.account_balance,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
          ]
           ),

          const SizedBox(
            height: 10,
          ),
          const Padding(padding: EdgeInsets.only(left: 10,right: 10),
          child:
          Divider(
            thickness: 1,
          ),
          ),
          const SizedBox(
            height: 5,
          ),


          //-----------------------------Premium portion-------------------//


          SizedBox(
            height: 350,
            width: double.maxFinite,
            //color: Colors.grey,
            child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(padding: EdgeInsets.only(left: 10,),
                    child:
                        Row(
                          children:[
                            Expanded(child:
                    Text('Premium',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10),
                            child:
                            TextButton(onPressed: null, child: Text("View All",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            ))
                            ),
                    ]
                  ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child:
                           FutureBuilder<List<hostels>>(
                          future: PremiumhostelData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final hostels = snapshot.data!;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hostels.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                     //hostels popuu = hostels[index];
                                    return GestureDetector(
                                      onTap:
                                          () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) {
                                              return HostelDetaisl(
                                                  details: hostels[index]);
                                            }));
                                      },
                                      child:
                                       Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 2,),
                                            child:
                                            Container(
                                              height: 280,
                                              width: 190,
                                              margin: const EdgeInsets.only(
                                                  left: 0),

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                //color: const Color(0xff0fc1fa).withOpacity(0.1),
                                                // gradient: LinearGradient(
                                                //   begin: Alignment.topCenter,
                                                //   end: Alignment.bottomCenter,
                                                //   colors: <Color>[
                                                //     Colors.black.withAlpha(0),
                                                //     Colors.orangeAccent,
                                                //     Colors.white
                                                //   ],
                                                // ),
                                              ),
                                              child:

                                               Card(
                                                shape: RoundedRectangleBorder(
                                                  // side: BorderSide(
                                                  //   color: Colors.greenAccent,
                                                  // ),
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      10.0), //<-- SEE HERE
                                                ),
                                                elevation: 10,
                                                child:
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [

                                                      Stack(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(top: 5,
                                                                left: 5,
                                                                right: 5),
                                                            child:
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: 180,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: AssetImage(
                                                                          "Assets/${hostels[index].photo}"),
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                          CornerBanner(
                                                            bannerPosition: CornerBannerPosition
                                                                .topLeft,
                                                            bannerColor: Theme
                                                                .of(context)
                                                                .colorScheme
                                                                .onSecondary,
                                                            child: Text(
                                                              "Premium",
                                                              style: TextStyle(
                                                                color: Theme
                                                                    .of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight: FontWeight
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 10, top: 5),
                                                        child:
                                                        Text(
                                                          hostels[index].name,
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(left: 10,),
                                                        child:
                                                        Text(
                                                          hostels[index].address,
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .w100,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      const Padding(
                                                          padding: EdgeInsets
                                                              .only(left: 10),
                                                          child:
                                                          Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                color: Color(
                                                                    0xff0fc1fa),
                                                              ),
                                                              Icon(Icons.star,
                                                                color: Color(
                                                                    0xff0fc1fa),
                                                              ),
                                                              Icon(Icons.star,
                                                                color: Color(
                                                                    0xff0fc1fa),
                                                              ),
                                                              Icon(Icons.star,
                                                                color: Color(
                                                                    0xff0fc1fa),
                                                              ),
                                                              Icon(Icons.star,
                                                                color: Colors
                                                                    .grey,
                                                              ),

                                                            ],
                                                          )
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              );
                            }
                          },
    )),
                ]
            ),
          ),
const SizedBox(
  height: 5,
),
const Padding(padding: EdgeInsets.only(left: 10,right: 10),
child:Divider(
  thickness: 1,
),
),
const SizedBox(
  height: 5,
),


          //---------------------Rated Portion--------------------------------------------------------//


          SizedBox(
            height: 350,
            width: double.maxFinite,
            //color: Colors.grey,
            child:Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Padding(padding: EdgeInsets.only(left: 10,),
                    child:
                    Row(
                        children:[
                          Expanded(child:
                          Text('Rated',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10),
                              child:
                              TextButton(onPressed: null, child: Text("View All",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ))
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child:
                      FutureBuilder<List<hostels>>(
                        future: RatedhostelData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final hostels = snapshot.data!;
                            return ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: hostels.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  //hostels popuu = hostels[index];
                                  return GestureDetector(
                                    onTap:
                                        () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) {
                                            return HostelDetaisl(
                                                details: hostels[index]);
                                          }));
                                    },
                                    child:
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 2,),
                                          child:
                                          Container(
                                            height: 280,
                                            width: 190,
                                            margin: const EdgeInsets.only(
                                                left: 0),

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              //color: const Color(0xff0fc1fa).withOpacity(0.1),
                                              // gradient: LinearGradient(
                                              //   begin: Alignment.topCenter,
                                              //   end: Alignment.bottomCenter,
                                              //   colors: <Color>[
                                              //     Colors.black.withAlpha(0),
                                              //     Colors.orangeAccent,
                                              //     Colors.white
                                              //   ],
                                              // ),
                                            ),
                                            child:

                                            Card(
                                              shape: RoundedRectangleBorder(
                                                // side: BorderSide(
                                                //   color: Colors.greenAccent,
                                                // ),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10.0), //<-- SEE HERE
                                              ),
                                              elevation: 10,
                                              child:
                                              Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [

                                                    Stack(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(top: 5,
                                                              left: 5,
                                                              right: 5),
                                                          child:
                                                          Container(
                                                            width: double
                                                                .infinity,
                                                            height: 180,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    10),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: AssetImage(
                                                                      "Assets/${hostels[index].photo}"),
                                                                )
                                                            ),
                                                          ),
                                                        ),
                                                        CornerBanner(
                                                          bannerPosition: CornerBannerPosition
                                                              .topLeft,
                                                          bannerColor: Theme
                                                              .of(context)
                                                              .colorScheme
                                                              .onSecondary,
                                                          child: Text(
                                                            "Rated",
                                                            style: TextStyle(
                                                              color: Theme
                                                                  .of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          left: 10, top: 5),
                                                      child:
                                                      Text(
                                                        hostels[index].name,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(left: 10,),
                                                      child:
                                                      Text(
                                                        hostels[index].address,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .w100,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    const Padding(
                                                        padding: EdgeInsets
                                                            .only(left: 10),
                                                        child:
                                                        Row(
                                                          children: [
                                                            Icon(Icons.star,
                                                              color: Color(
                                                                  0xff0fc1fa),
                                                            ),
                                                            Icon(Icons.star,
                                                              color: Color(
                                                                  0xff0fc1fa),
                                                            ),
                                                            Icon(Icons.star,
                                                              color: Color(
                                                                  0xff0fc1fa),
                                                            ),
                                                            Icon(Icons.star,
                                                              color: Color(
                                                                  0xff0fc1fa),
                                                            ),
                                                            Icon(Icons.star,
                                                              color: Colors
                                                                  .grey,
                                                            ),

                                                          ],
                                                        )
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          }
                        },
                      )),
                  // Expanded(
                  //     child:
                  //
                  //     ListView.builder(
                  //         shrinkWrap: true,
                  //         primary: false,
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: DataStore.rec.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           hostels reccom = DataStore.rec[index];
                  //           return GestureDetector(
                  //             onTap:
                  //                 () {
                  //               Navigator.of(context)
                  //                   .push(MaterialPageRoute(builder: (context) {
                  //                 return HostelDetaisl(details: reccom);
                  //               }));
                  //             },
                  //             child:
                  //             Column(
                  //               children:[
                  //                 Padding(padding: const EdgeInsets.only(left: 10,bottom: 30),
                  //                   child:
                  //                   Container(
                  //                     height: 280,
                  //                     width: 180,
                  //                     margin: const EdgeInsets.only(left: 0),
                  //
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(20),
                  //                       //color: const Color(0xff0fc1fa).withOpacity(0.1),
                  //                       // gradient: LinearGradient(
                  //                       //   begin: Alignment.topCenter,
                  //                       //   end: Alignment.bottomCenter,
                  //                       //   colors: <Color>[
                  //                       //     Colors.black.withAlpha(0),
                  //                       //     Colors.orangeAccent,
                  //                       //     Colors.white
                  //                       //   ],
                  //                       // ),
                  //                     ),
                  //                     child:
                  //                         Card(
                  //                           shape: RoundedRectangleBorder(
                  //                             // ),
                  //                             borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                  //                           ),
                  //                           elevation: 10,
                  //                           child:
                  //                     Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children:[
                  //                           Stack(
                  //                             children: [
                  //                               Padding(padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
                  //                                 child:
                  //                                 Container(
                  //                                   width: double.infinity,
                  //                                   height: 180,
                  //                                   decoration: BoxDecoration(
                  //                                       borderRadius: BorderRadius.circular(10),
                  //                                       shape: BoxShape.rectangle,
                  //                                       image: DecorationImage(
                  //                                           fit: BoxFit.cover,
                  //                                           image: AssetImage(reccom.photo)
                  //                                       )
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               CornerBanner(
                  //                                 bannerPosition: CornerBannerPosition.topLeft,
                  //                                 bannerColor: Theme.of(context).colorScheme.primary,
                  //                                 child: const Text("Rated",
                  //                                   style: TextStyle(
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //
                  //                             ],
                  //                           ),
                  //                           Padding(padding: const EdgeInsets.only(left: 10,top: 5),
                  //                           child:
                  //                           Text(
                  //                             reccom.name,
                  //                             style: const TextStyle(
                  //                               fontSize: 15,
                  //                               fontWeight: FontWeight.w700,
                  //                               color: Colors.black,
                  //                             ),
                  //                           ),
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 2,
                  //                           ),
                  //                       Padding(padding: const EdgeInsets.only(left: 10),
                  //                           child:
                  //                           Text(
                  //                             reccom.address,
                  //                             style: const TextStyle(
                  //                               fontSize: 15,
                  //                               fontWeight: FontWeight.w100,
                  //                             ),
                  //                           ),
                  //                       ),
                  //                           const SizedBox(
                  //                             height: 2,
                  //                           ),
                  //                           const Padding(padding: EdgeInsets.only(left: 10),
                  //                             child:
                  //                             Row(
                  //                               children: [
                  //                                 Icon(Icons.star,
                  //                                 color: Color(0xff0fc1fa),
                  //                                 ),
                  //                                 Icon(Icons.star,
                  //                                   color: Color(0xff0fc1fa),
                  //                                 ),
                  //                                 Icon(Icons.star,
                  //                                   color: Color(0xff0fc1fa),
                  //                                 ),
                  //                                 Icon(Icons.star,
                  //                                   color: Color(0xff0fc1fa),
                  //                                 ),
                  //                                 Icon(Icons.star,
                  //                                   color: Colors.grey,
                  //                                 ),
                  //
                  //                               ],
                  //                             )
                  //                           ),
                  //
                  //                         ]
                  //                     ),
                  //                   ),
                  //                     ),
                  //                 ),
                  //               ],
                  //             ),);
                  //         }
                  //     ),
                  // ),
                ]
            ),
          ),
  ]
),
      ),
      ),
      ),
    );
  }
}