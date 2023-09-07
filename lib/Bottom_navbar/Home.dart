import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:findyournewhome/Hostels/main_page.dart';
import 'package:findyournewhome/Portal/studentportal_firstscreen.dart';
//import 'package:findyournewhome/User%20profile/myreservations.dart';
import 'package:flutter/material.dart';

import '../myreservations/myreservations.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);
  final _controller = NotchBottomBarController(index: 1);

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    ReservationListScreen(),
    const home_page(),
    const studentportal_first(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
          color: Theme.of(context).colorScheme.primary,
          showLabel: false,
          notchColor: Theme.of(context).colorScheme.onPrimary,
          notchBottomBarController: _controller,
          bottomBarItems:  [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                //color: Colors.white,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeItem: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
              itemLabel: 'Page 1',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeItem: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              itemLabel: 'Page 2',
            ),

            BottomBarItem(
              inActiveItem: Icon(
                Icons.desktop_windows,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeItem: Icon(
                Icons.desktop_windows,
                color: Theme.of(context).colorScheme.primary,
              ),
              itemLabel: 'Page 3',
            ),
          ],
          onTap: (index) {
            /// control your animation using page controller
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        )
            : null,
    );
        }
}