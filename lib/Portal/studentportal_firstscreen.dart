import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:findyournewhome/Portal/student_portal.dart';
import 'package:flutter/material.dart';

import '../contants/navigatortransition.dart';
class studentportal_first extends StatefulWidget {
  const studentportal_first({Key? key}) : super(key: key);

  @override
  State<studentportal_first> createState() => _studentportal_firstState();
}

class _studentportal_firstState extends State<studentportal_first> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "Assets/background5.0.jpg"),
          fit: BoxFit.cover,
          opacity: 0.5,

        ),
        ),
    child:  Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 300,maxHeight: 500), // Adjust the max width as needed
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
          height: 100,
          child:
              Center(child: AnimatedTextKit(
                  repeatForever: true,
                  pause: Duration(seconds: 3),
                  stopPauseOnTap: true,

                  animatedTexts: [
                    RotateAnimatedText('Hostel-Hunt',
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    RotateAnimatedText('Hostel Management\n System',
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Theme
                            .of(context)
                            .colorScheme.primary,
                      ),
                    ),
                  ])
              ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 200,
                width: 200,
                child: Image.asset("Assets/website.gif"),
              ),
              Text('Click here to open HMS'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 50.0,
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(FadePageRoute(page: student_portal()));
                    },
                    child: Text(
                      "Click me",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    //   child:   Padding(padding: const EdgeInsets.all(30),
    //   child:
    //   Card(
    //     elevation: 10,
    //     shadowColor: Colors.black,
    //     //color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //          Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
    //         child:Text(' HMS',
    //         style: TextStyle(
    //           fontWeight: FontWeight.w600,
    //           fontSize: 40,
    //           color: Theme.of(context).colorScheme.primary,
    //         ),
    //         ),
    //         ),
    //           const SizedBox(
    //           height:  30,
    //           ),
    //         Container(
    //           height: 200,
    //           width: 200,
    //           child: Image.asset("Assets/website.gif"),
    //         ),
    //         const Text('Click here to open HMS',),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //       Expanded(
    //         flex: 1,
    //         child:
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children:[
    //             FittedBox(
    //
    //               child:Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: <Widget>[
    //
    //                   ElevatedButton(
    //                       style: ButtonStyle(
    //                           padding: MaterialStateProperty.all(
    //                             const EdgeInsets.symmetric(
    //                                 vertical: 20.0, horizontal: 50.0),
    //                           ),
    //                           foregroundColor: MaterialStateProperty.all<
    //                               Color>(Theme.of(context).colorScheme.onPrimary,),
    //                           backgroundColor: MaterialStateProperty.all<
    //                               Color>( Theme.of(context).colorScheme.primary,),
    //                           shape: MaterialStateProperty.all<
    //                               RoundedRectangleBorder>(
    //                               RoundedRectangleBorder(
    //                                 side:  BorderSide(color: Theme.of(context).colorScheme.primary,),
    //                                 borderRadius: BorderRadius.circular(
    //                                     18.0),
    //                               )
    //                           )
    //                       ),
    //                       onPressed: () {
    //                         Navigator.pushReplacement(context,
    //                           MaterialPageRoute(builder: (context) => student_portal(),
    //
    //                           ),
    //                         );
    //                       },
    //                       child: const Text(
    //                         "Click me",
    //                         style: TextStyle(fontSize: 20),
    //                       )
    //                   ),
    //
    //
    //                 ],
    //               ),
    //             ),
    //       ],
    //     ),
    //   )
    //       ]
    //   ),
    // )
    // )
    );
  }
}
