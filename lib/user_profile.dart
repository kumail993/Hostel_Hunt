import 'package:flutter/material.dart';

import 'Home.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("Assets/Background.jpg"),
    fit: BoxFit.cover,
    ),
    ),
        child: Column(
          children: [
            Container(
              color: const Color(0xff0fc1fa),
              height: 50,
              width: double.infinity,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 10),
                    child:
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>const MyHomePage(),

                          ),
                        );
                      },
                      child:
                      const Icon(Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 120,),
                    child:
                    Text('User Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              //minRadius: 20,
              //maxRadius: 80,
              radius: 80.0,
              backgroundColor: Colors.grey,
              foregroundColor: Colors.black,
              child:
                  SizedBox(
                    height: 200,
                    width: 200,
                    child:
              ClipOval(
                child:
              Image.asset('Assets/5.jpg',fit: BoxFit.fill,),
            ),
            ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Kumail Haider Sangi'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(padding: EdgeInsets.only(left: 20,right: 20),
            child: Divider(
              thickness: 2,
            )
            ),
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text('Khaider308@gmail.com'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                  thickness: 2,
                )
            ),
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: Icon(Icons.location_city_outlined),
              title: Text('Islamabad'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                  thickness: 2,
                ),
            ),

          ],
        ),
    )
    );
  }
}
