import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:findyournewhome/Hostels/hostel_details.dart';
//import 'package:findyournewhome/User%20profile/myreservations.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_banners/super_banners.dart';
import '../contants/navigatortransition.dart';
import '../models/hostels.dart';
import '../myreservations/myreservations.dart';
import '../rest/HostelsFetch_API.dart';


class home_page extends StatefulWidget {
  const home_page({Key? key,}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late Future<List<hostels>> PremiumhostelData;
  late Future<List<hostels>> RatedhostelData;
  late Future<List<hostels>> AllhostelData;

  late String email_id = '';

  //late SharedPreferences _sharedPreferences;

  _loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        email_id = prefs.getString('usermail')!;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    PremiumhostelData = fetchPremiumHostel();
    RatedhostelData = fetchRatedHostel();
    AllhostelData = fetchAllHostel();
    _loadData();
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .secondary,
      appBar: AppBar(
        title: Center(child: AnimatedTextKit(
            repeatForever: true,
            pause: Duration(seconds: 3),
            stopPauseOnTap: true,

            animatedTexts: [
              RotateAnimatedText('Hostel Hunt',
                  textStyle: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onPrimary,
                  ),
                duration:const Duration(seconds: 5),
              ),
              RotateAnimatedText('Find Your Hostel',
                  textStyle: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                duration:const Duration(seconds: 5),
              ),
            ])
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 10),
            child:
            FutureBuilder<List<hostels>>(
                future: AllhostelData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final hostels = snapshot.data!;
                    return
                      InkWell(
                        child:
                        const Icon(Icons.search_outlined,),

                        onTap: () =>
                            showSearch(
                              context: context,
                              delegate:
                              SearchPage(
                                //onQueryUpdate: print,
                                items: hostels,
                                searchLabel: "Search Hostel",
                                searchStyle: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onPrimary,

                                )
                                ,
                                suggestion:
                                Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "Assets/gradient_4_16.jpg"),
                                      fit: BoxFit.cover,
                                      opacity: 0.6,

                                    ),
                                  ),
                                  child:
                                  Center(
                                      child: Image.asset(
                                        'Assets/Search2.0.gif', height: 200,
                                        width: 200,)
                                  ),
                                ),
                                failure:
                                Center(
                                  //child: Text('No Hostel found :('),
                                    child: Image.asset(
                                      'Assets/not found.gif', height: 200,
                                      width: 200,)
                                ),
                                filter: (hostels) =>
                                [
                                  hostels.name,
                                  //hostels.roomTypeData,
                                  //person.surname,
                                  //hostels.rent.toString(),
                                ],
                                sort: (a, b) => a.compareTo(b),
                                builder: (hostels) =>
                                    GestureDetector(
                                      onTap:
                                          () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) {
                                              return HostelDetaisl(
                                                  details: hostels);
                                            }));
                                      },
                                      child:
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          // side: BorderSide(
                                          //   color: Colors.greenAccent,
                                          // ),
                                          borderRadius: BorderRadius.circular(
                                              10.0), //<-- SEE HERE
                                        ),
                                        elevation: 10,
                                        child:
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 5, right: 5),
                                                child:
                                                Container(
                                                  width: double.infinity,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          10),
                                                      shape: BoxShape.rectangle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              "Assets/${hostels
                                                                  .photo}")
                                                      )
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 5),
                                                child:
                                                Text(
                                                  hostels.name,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,),
                                                child:
                                                Text(
                                                  hostels.address,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                              ),),
                      );
                  }
                }
            ),
          )
        ],
      ),
      drawer:
      //color: Theme.of(context).colorScheme.onPrimary,
      Drawer(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .secondary,

        child:
        ListView(
          physics: const NeverScrollableScrollPhysics(),

          children: <Widget>[
            const SizedBox(
              height: 30,
            ),

            const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(padding: EdgeInsets.only(left: 30,),
                    child:
                    Column(
                        children: [
                          CircleAvatar(
                            minRadius: 50,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("Assets/logo4.0.png",
                            ),
                          ),

                        ]
                    ),
                  ),

                ]
            ),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 30),
                    child:
                    Text(email_id,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ]
            ),


            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(padding: const EdgeInsets.only(left: 5,),
              child:
              ListTile(

                //leading: Icon(Icons.article),
                title: const Text("My Reservations",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (context) => ReservationListScreen(),

                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
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
                onTap: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage(),

                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
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
              height: 30,
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
                onTap: () {

                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              title: const Text("Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage(),

                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/gradient_4_16.jpg"),
            fit: BoxFit.cover,
            opacity: 1.0,

          ),
        ),
        child:

        SingleChildScrollView(
          child:
          Padding(padding: const EdgeInsets.only(bottom: 50),
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  SizedBox(
                    //color: const Color(0xff0fc1fa).withOpacity(0.4),
                    height: 250,
                    width: double.maxFinite,
                    child: CarouselSlider(items: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                          Image.asset(
                              "Assets/promotion1.jpeg", width: 500,
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                          Image.asset(
                              'Assets/promotion5.webp', width: 400,
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                          Image.asset(
                              'Assets/promotion3.png', width: 400,
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                          Image.asset(
                              'Assets/promotion4.png', width: 400,
                              fit: BoxFit.fill),
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
                        autoPlayAnimationDuration: const Duration(
                            milliseconds: 800),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          _currentIndex = index;
                          setState(() {});
                        },
                      ),

                    ),
                  ),
                  Center(child:
                  DotsIndicator(
                    dotsCount: 4,
                    position: _currentIndex,
                    decorator: DotsDecorator(
                        color: Colors.grey,
                        activeColor: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                  ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10, right: 10),
                    child:
                    Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),


                  //-----------------------------Premium portion-------------------//


                  SizedBox(
                    height: 350,
                    width: double.maxFinite,
                    //color: Colors.grey,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(padding: const EdgeInsets.only(left: 10,),
                            child:
                            Row(
                                children: [

                                  const Text('Premium',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.only(
                                      left: 5, right: 10),
                                      child:
                                      Icon(Icons.workspace_premium_sharp,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .onSecondary,
                                      )
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
                                    return const Center(
                                        child: CircularProgressIndicator());
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
                                              Navigator.of(context).push(
                                                  FadePageRoute(
                                                      page: HostelDetaisl(
                                                          details: hostels[index])));
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //     builder: (context) {
                                              //       return HostelDetaisl(
                                              //           details: hostels[index]);
                                              //     }));
                                            },
                                            child:
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                    left: 2,),
                                                  child:
                                                  Container(
                                                    height: 280,
                                                    width: 190,
                                                    margin: const EdgeInsets
                                                        .only(
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
                                                        //   color: Theme.of(context).colorScheme.surface,
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
                                                                      .only(
                                                                      top: 5,
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
                                                                              "Assets/${hostels[index]
                                                                                  .photo}"),
                                                                        )
                                                                    ),
                                                                  ),
                                                                ),
                                                                CornerBanner(
                                                                  bannerPosition: CornerBannerPosition
                                                                      .topLeft,
                                                                  bannerColor: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .onSecondary,
                                                                  child: Text(
                                                                    "Premium",
                                                                    style: TextStyle(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
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
                                                                  left: 10,
                                                                  top: 5),
                                                              child:
                                                              Text(
                                                                hostels[index]
                                                                    .name,
                                                                style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight
                                                                      .w700,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                left: 10,),
                                                              child:
                                                              Text(
                                                                hostels[index]
                                                                    .address,
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
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                                child:
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.bed_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
                                                                    ),
                                                                    Icon(Icons.food_bank_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context).colorScheme.onPrimary,
                                                                    ),
                                                                    Icon(Icons.electric_bolt_rounded,
                                                                      color: Theme.of(context).colorScheme.onPrimary,),
                                                                    Icon(Icons.room_service_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
                                                                    ),
                                                                    Icon(Icons.night_shelter_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
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
                  const Padding(padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
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
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Padding(padding: EdgeInsets.only(left: 10,),
                            child:
                            Row(
                                children: [

                                  Text('Rated',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(
                                      left: 5, right: 10),
                                      child:
                                      Icon(Icons.star_rate_outlined,)
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
                                    return const Center(
                                        child: CircularProgressIndicator());
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
                                              Navigator.of(context).push(
                                                  FadePageRoute(
                                                      page: HostelDetaisl(
                                                          details: hostels[index])));
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //     builder: (context) {
                                              //       return HostelDetaisl(
                                              //           details: hostels[index]);
                                              //     }));
                                            },
                                            child:
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                    left: 2,),
                                                  child:
                                                  Container(
                                                    height: 280,
                                                    width: 190,
                                                    margin: const EdgeInsets
                                                        .only(
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
                                                                      .only(
                                                                      top: 5,
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
                                                                              "Assets/${hostels[index]
                                                                                  .photo}"),
                                                                        )
                                                                    ),
                                                                  ),
                                                                ),
                                                                CornerBanner(
                                                                  bannerPosition: CornerBannerPosition
                                                                      .topLeft,
                                                                  bannerColor: Theme
                                                                      .of(
                                                                      context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  child: Text(
                                                                    "Rated",
                                                                    style: TextStyle(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
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
                                                                  left: 10,
                                                                  top: 5),
                                                              child:
                                                              Text(
                                                                hostels[index]
                                                                    .name,
                                                                style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight
                                                                      .w700,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                left: 10,),
                                                              child:
                                                              Text(
                                                                hostels[index]
                                                                    .address,
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
                                                            Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                                child:
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.bed_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
                                                                    ),
                                                                    Icon(Icons.food_bank_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context).colorScheme.onPrimary,
                                                                    ),
                                                                    Icon(Icons.electric_bolt_rounded,
                                                                      color: Theme.of(context).colorScheme.onPrimary,),
                                                                    Icon(Icons.room_service_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
                                                                    ),
                                                                    Icon(Icons.night_shelter_outlined,
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .onPrimary,
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
                ]
            ),
          ),
        ),
            )
    );
  }
}

// class ResponsiveAppBar extends StatelessWidget {
//
//   final  Future<List<hostels>> hostelData;
//
//    ResponsiveAppBar({required this.hostelData});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     // Calculate text size based on screen width
//     final titleTextSize = screenWidth < 600 ? 20.0 : 30.0;
//     final subtitleTextSize = screenWidth < 600 ? 14.0 : 20.0;
//
//     return AppBar(
//       title: Center(
//         child: AnimatedTextKit(
//           repeatForever: true,
//           pause: const Duration(seconds: 3),
//           stopPauseOnTap: true,
//           animatedTexts: [
//             RotateAnimatedText(
//               'Hostel Hunt',
//               textStyle: TextStyle(
//                 color: Theme.of(context).colorScheme.onPrimary,
//                 fontSize: titleTextSize,
//               ),
//             ),
//             RotateAnimatedText(
//               'Find Your Hostel',
//               textStyle: TextStyle(
//                 color: Theme.of(context).colorScheme.secondary,
//                 fontSize: subtitleTextSize,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       actions: [
//         Padding(padding: const EdgeInsets.only(right: 10),
//           child:
//           FutureBuilder<List<hostels>>(
//               future: hostelData,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   final hostels = snapshot.data!;
//                   return
//                     InkWell(
//                       child:
//                       const Icon(Icons.search_outlined,),
//
//                       onTap: () =>
//                           showSearch(
//                             context: context,
//                             delegate:
//                             SearchPage(
//                               //onQueryUpdate: print,
//                               items: hostels,
//                               searchLabel: "Search Hostel",
//                               searchStyle: TextStyle(
//                                 color: Theme
//                                     .of(context)
//                                     .colorScheme
//                                     .onPrimary,
//
//                               )
//                               ,
//                               suggestion:
//                               Container(
//                                 height: double.maxFinite,
//                                 width: double.maxFinite,
//                                 decoration: const BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                         "Assets/gradient_4_16.jpg"),
//                                     fit: BoxFit.cover,
//                                     opacity: 0.6,
//
//                                   ),
//                                 ),
//                                 child:
//                                 Center(
//                                     child: Image.asset(
//                                       'Assets/Search2.0.gif', height: 200,
//                                       width: 200,)
//                                 ),
//                               ),
//                               failure:
//                               Center(
//                                 //child: Text('No Hostel found :('),
//                                   child: Image.asset(
//                                     'Assets/not found.gif', height: 200,
//                                     width: 200,)
//                               ),
//                               filter: (hostels) =>
//                               [
//                                 hostels.name,
//                                 //hostels.roomTypeData,
//                                 //person.surname,
//                                 //hostels.rent.toString(),
//                               ],
//                               sort: (a, b) => a.compareTo(b),
//                               builder: (hostels) =>
//                                   GestureDetector(
//                                     onTap:
//                                         () {
//                                       Navigator.of(context)
//                                           .push(MaterialPageRoute(
//                                           builder: (context) {
//                                             return HostelDetaisl(
//                                                 details: hostels);
//                                           }));
//                                     },
//                                     child:
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         // side: BorderSide(
//                                         //   color: Colors.greenAccent,
//                                         // ),
//                                         borderRadius: BorderRadius.circular(
//                                             10.0), //<-- SEE HERE
//                                       ),
//                                       elevation: 10,
//                                       child:
//                                       Column(
//                                           crossAxisAlignment: CrossAxisAlignment
//                                               .start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 5, left: 5, right: 5),
//                                               child:
//                                               Container(
//                                                 width: double.infinity,
//                                                 height: 180,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius
//                                                         .circular(
//                                                         10),
//                                                     shape: BoxShape.rectangle,
//                                                     image: DecorationImage(
//                                                         fit: BoxFit.cover,
//                                                         image: AssetImage(
//                                                             "Assets/${hostels
//                                                                 .photo}")
//                                                     )
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 10, top: 5),
//                                               child:
//                                               Text(
//                                                 hostels.name,
//                                                 style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w700,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 2,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                 left: 10,),
//                                               child:
//                                               Text(
//                                                 hostels.address,
//                                                 style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w100,
//                                                 ),
//                                               ),
//                                             ),
//                                           ]
//                                       ),
//                                     ),
//                                   ),
//                             ),),
//                     );
//                 }
//               }
//           ),
//         )
//       ],
//
//     );
//   }
//}



// class SlidePageRoute<T> extends PageRouteBuilder<T> {
//   final Widget page;
//
//   SlidePageRoute({required this.page})
//       : super(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0); // Start position
//       const end = Offset.zero; // End position
//       const curve = Curves.easeInOut; // Animation curve
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       var offsetAnimation = animation.drive(tween);
//
//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }
