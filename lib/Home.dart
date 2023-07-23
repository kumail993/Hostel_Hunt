import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:findyournewhome/main_page.dart';
import 'package:findyournewhome/studentportal_firstscreen.dart';
import 'package:findyournewhome/user_profile.dart';
import 'package:flutter/material.dart';
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
    const
    profile(),
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
          color: const Color(0xff0fc1fa),
          showLabel: false,
          notchColor: Colors.white,
          notchBottomBarController: _controller,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.person,
                color: Color(0xff0fc1fa),
              ),
              itemLabel: 'Page 1',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.home,
                color: Color(0xff0fc1fa),
              ),
              itemLabel: 'Page 2',
            ),

            BottomBarItem(
              inActiveItem: Icon(
                Icons.desktop_windows,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.desktop_windows,
                color: Color(0xff0fc1fa),
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