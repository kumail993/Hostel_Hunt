import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildContactCard(
                context,
                Icons.phone,
                '(+92) 332-0214556',
              ),
              SizedBox(height: 20),
              _buildContactCard(
                context,
                Icons.email,
                'hostelhunts@gmail.com',
              ),
              SizedBox(height: 20),
              _buildContactCard(
                context,
                Icons.location_on,
                'Greens Avenue , Park Road ,Islamabad',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, IconData icon, String text) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        //onTap: () => _launchPhoneCall(text),
      ),
    );
  }
  // void _launchPhoneCall(String phoneNumber) async {
  //   // Remove any non-numeric characters from the phone number
  //   final formattedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
  //
  //   // Check if the formatted phone number is not empty
  //   if (formattedPhoneNumber.isNotEmpty) {
  //     final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: formattedPhoneNumber);
  //
  //     if (await canLaunch(_phoneLaunchUri.toString())) {
  //       await launch(_phoneLaunchUri.toString());
  //     } else {
  //       throw 'Could not launch phone call';
  //     }
  //   } else {
  //     throw 'Invalid phone number';
  //   }
  // }

}


