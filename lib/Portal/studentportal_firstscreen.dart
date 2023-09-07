import 'package:findyournewhome/Portal/student_portal.dart';
import 'package:flutter/material.dart';
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
              "Assets/gradient_4_16.jpg"),
          fit: BoxFit.cover,
          opacity: 0.6,

        ),
        ),
      child:   Padding(padding: const EdgeInsets.all(50),
      child:
      Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child:Text(' HMS',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 40,
              color: Theme.of(context).colorScheme.surface,
            ),
            ),
            ),
              const SizedBox(
              height:  30,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child:
                ClipOval(
                  child:
                  Image.asset('Assets/desktop.jpg',fit: BoxFit.fill,),
                ),
              ),
            const Text('Click here to open HMS',),
            const SizedBox(
              height: 10,
            ),
          Expanded(
            flex: 1,
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
                                  Color>(Theme.of(context).colorScheme.onPrimary,),
                              backgroundColor: MaterialStateProperty.all<
                                  Color>( Theme.of(context).colorScheme.primary,),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side:  BorderSide(color: Theme.of(context).colorScheme.primary,),
                                    borderRadius: BorderRadius.circular(
                                        18.0),
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => student_portal(),

                              ),
                            );
                          },
                          child: const Text(
                            "Click me",
                            style: TextStyle(fontSize: 20),
                          )
                      ),


                    ],
                  ),
                ),
          ],
        ),
      )
          ]
      ),
    )
    )
    );
  }
}
