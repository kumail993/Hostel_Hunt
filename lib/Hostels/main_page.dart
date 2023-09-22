import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:findyournewhome/About%20Us/AboutUs_Screen.dart';
import 'package:findyournewhome/About%20Us/contact_us.dart';
import 'package:findyournewhome/Portal/studentportal_firstscreen.dart';
import 'package:findyournewhome/UserAuthentication/Screens/Login_page.dart';
import 'package:findyournewhome/Hostels/hostel_details.dart';
//import 'package:findyournewhome/User%20profile/myreservations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
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

  late Future<List<Hostel>> AllhostelData;


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

  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }


  @override
  void initState() {
    super.initState();
     AllhostelData = fetchPostData();
    _loadData();
  }


  @override
  Widget build(BuildContext context) {
    return
      SideMenu(
        key: _endSideMenuKey,
        inverse: true, // end side menu
        background: Colors.green[700],
        type: SideMenuType.slideNRotate,
        menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
    child: buildMenu(),
    ),
    onChange: (_isOpened) {
    setState(() => isOpened = _isOpened);
    },
    child: SideMenu(
    key: _sideMenuKey,
    menu: buildMenu(),
    background: Theme.of(context).colorScheme.primary,
    type: SideMenuType.slideNRotate,
    onChange: (_isOpened) {
    setState(() => isOpened = _isOpened);
    },
    child: IgnorePointer(
    ignoring: isOpened,
    child: Scaffold(
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
      ),
      RotateAnimatedText('Find Your Hostel',
      textStyle: TextStyle(
      color: Theme
          .of(context)
          .colorScheme
          .secondary,
      ),
      ),
      ]),
    ),
    centerTitle: true,
    leading: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () => toggleMenu(),
    ),
            actions: [
              Padding(padding: const EdgeInsets.only(right: 10),
                child:
                FutureBuilder<List<Hostel>>(
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
                                              "Assets/background5.0.jpg"),
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
                                      //hostels.getAddress(),
                                      hostels.HostelName,
                                      hostels.getRent(),
                                      //hostels.roomTypeData,
                                      //person.surname,
                                      //hostels.rent.toString(),
                                    ],
                                    sort: (a, b) => a.compareTo(b),

                                    builder: (hostels,) {
                                      final imageUrl = hostels.Images.isNotEmpty
                                          ? hostels.Images[0]
                                          : '';
                                      final String address = hostels.getAddress();
                                      final String rent = hostels.getRent();
                                      final String rooms = hostels.getRooms();
                                      final String enquiry_to = hostels.getAgent();
                                      return GestureDetector(
                                        onTap:
                                            () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                              builder: (context) {
                                                return HostelDetaisl(
                                                    details: hostels, image: imageUrl ,address:address,rent:rent,agent:enquiry_to ,rooms: rooms,);
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
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 5,
                                                      left: 5,
                                                      right: 5),
                                                  child:
                                                  Container(
                                                    width: double.infinity,
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            10),
                                                        shape: BoxShape
                                                            .rectangle,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                imageUrl)
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 10, top: 5),
                                                  child:
                                                  Text(
                                                    hostels.HostelName,
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
                                                      .only(
                                                    left: 10,),
                                                  child:
                                                  Text(
                                                    address,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight
                                                          .w100,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      );
                                    }
                                  ),),
                          );
                      }
                    }
                ),
              )
            ],
          ),
          body: Container(
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
                                  'Assets/Hostel Hunt-promotion.png', width: 400,
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
                                  FutureBuilder<List<Hostel>>(
                                    future: AllhostelData,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text('Hostels Not Found');
                                      } else {
                                        final hostels = snapshot.data!;

                                        return ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: hostels.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final post = hostels[index];
                                              final String address = post.getAddress();
                                              final String rooms = post.getRooms();
                                              final String bathroom = post.getBathroom();
                                              final String rent = post.getRent();
                                              final String enquiry_to = post.getAgent();
                                              final List<dynamic> images = post.Images;

                                              // Assuming you want to display the first image in the list
                                              final imageUrl = images.isNotEmpty ? images[0] : '';
                                              return GestureDetector(
                                                onTap:
                                                    () {
                                                      Navigator.of(context).push(
                                                          FadePageRoute(
                                                              page: HostelDetaisl(
                                                                  details: hostels[index], image: imageUrl, address:address,rent:rent,agent: enquiry_to,rooms: rooms,)));
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
                                                        height: 316,
                                                        width: 190,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 0),

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(30),
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
                                                                              image: NetworkImage(imageUrl),
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
                                                                        "",
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
                                                                    post.HostelName,
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
                                                                    address,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 2,
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
                                                                              .primary,
                                                                        ),
                                                                         Text(rooms),
                                                                        SizedBox(width: 20,),
                                                                        Icon(Icons.bathroom,
                                                                          color: Theme
                                                                              .of(
                                                                              context)
                                                                              .colorScheme
                                                                              .primary,
                                                                        ),
                                                                         Text(bathroom),

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
                            ]
                        ),
                      ),
                ),
              ),
                      ),
                      )
    ),
      );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding:  EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               ProfilePicture(name: email_id, radius: 25, fontsize: 20,random: true,),
                SizedBox(height: 16.0),
                Text(email_id,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,

                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(FadePageRoute(page: ReservationListScreen()));
            },
            leading: const Icon(Icons.notes, size: 20.0, color: Colors.white),
            title: const Text("Reservations"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(FadePageRoute(page: studentportal_first()));
            },
            leading: const Icon(Icons.desktop_windows,
                size: 20.0, color: Colors.white),
            title: const Text("Portal"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).push(FadePageRoute(page: AboutUsScreen()));
            },
            leading:
            const Icon(Icons.home_filled, size: 20.0, color: Colors.white),
            title: const Text("About us"),
            textColor: Colors.white,
            dense: true,


            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
               Navigator.of(context).push(FadePageRoute(page: ContactUs()));
            },
            leading:
            const Icon(Icons.phone, size: 20.0, color: Colors.white),
            title: const Text("Contact Us"),
            textColor: Colors.white,
            dense: true,


            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(FadePageRoute(page: LoginPage()));
            },
            leading:
            const Icon(Icons.logout_outlined, size: 20.0, color: Colors.white),
            title: const Text("Logout"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

