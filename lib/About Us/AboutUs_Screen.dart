import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Founders',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FounderCard(
                  imagePath: 'Assets/kumail.jpeg', // Replace with actual image path
                  founderName: 'Kumail Haider',
                ),
                FounderCard(
                  imagePath: 'Assets/mansoor.jpeg', // Replace with actual image path
                  founderName: 'Mansoor Azam',
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Who We Are',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to our platform, where convenience meets comfort. We are your dedicated partners in simplifying the process of finding the perfect accommodation. We proudly present a user-friendly website, a dynamic mobile app, and an efficient hostel management system. Our mission is to bridge the gap between eager students searching for their ideal room and welcoming hostel owners to showcase their hostels. We’re not just a service; we’re a community that believes in creating memorable experiences. Join us and embark on a journey where reserving a room is as effortless as a click, and where hostel owners can effortlessly expand their reach. Discover ease, discover comfort – discover us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Text(
            //   'Contact Information',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            // ),
            // SizedBox(height: 10.0),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: Icon(Icons.phone),
            //         title: Text('Phone Number: +92 332-0214556'),
            //       ),
            //       ListTile(
            //         leading: Icon(Icons.location_on),
            //         title: Text('Address:Park Road Islamabad'),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.0),
            Text(
              'Our Purpose',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'For hostel seekers, Hostel-hunt offers a user-friendly and intuitive Web Application and mobile application that simplifies the daunting task of finding suitable hostels. The product provides a robust search engine with filters based on location, price, amenities, and user reviews. Hostel seekers can browse through detailed hostel profiles, view high-quality images, and make informed decisions about their accommodation choices. Additionally, the application facilitates secure online reservations, enabling users to reserve their preferred hostel rooms with ease.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FounderCard extends StatelessWidget {
  final String imagePath;
  final String founderName;

  FounderCard({required this.imagePath, required this.founderName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 8.0),
        Text(
          founderName,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
