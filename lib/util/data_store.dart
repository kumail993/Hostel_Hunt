import 'dart:convert';

import '../models/cars.dart';
import 'package:http/http.dart'as http;
class DataStore {

//   static List<popular> pop = [
//
//     popular(name: 'Abasyn Boys Hostel', rating: '4.5', photo: 'Assets/1.jpg', type: 'Boys',address: 'Park Road',rent: '10000'),
//     popular(name: 'Royal Girls Hostel', rating: '3.5', photo: 'Assets/2.jpg', type: 'Boys',address: 'chak shahzad',rent: '12000'),
//     popular(name: 'Noor Bloack', rating: '4.9', photo: 'Assets/3.jpg', type: 'boys',address: 'Royal Avenue',rent: '13000'),
//     popular(name: 'Shahzad block', rating: '4.2', photo: 'Assets/4.jpg', type: 'boys',address: 'islamabad',rent: '14000'),
//     popular(name: 'Hello', rating: '4.0', photo: 'Assets/5.jpg', type: 'M',address: 'Park road ',rent: '12000'),
//
//   ];
//   static List<Recommended> rec = [
//     Recommended(address: '', name: 'Abasyn Boys Hostel', photo: 'Assets/6.jpg', rating: '', type: '',rent: '18000'),
//     Recommended(address: 'address', name: 'Hello G', photo: 'Assets/7.jpg', rating: '', type: '',rent: '16000'),
//     Recommended(address: 'address', name: 'kese ho hostel', photo: 'Assets/8.jpg', rating: '', type: '',rent: '12000'),
//     Recommended(address: '', name: 'Naam ni hai hamara', photo: 'Assets/9.jpg', rating: '', type: '',rent: '1000'),
//     Recommended(address: '', name: 'Picture hi kaafi hai', photo: 'Assets/splash screen.jpg', rating: '', type: '',rent: '12000')
//   ];
// }
// mixin Datastore implements DataStore {
//   static List<hostels> hos = [
//     popular(name: 'Abasyn Boys Hostel', rating: '4.5', photo: 'Assets/1.jpg', type: 'Boys',address: 'Park Road',rent: '10000'),
//     popular(name: 'Royal Girls Hostel', rating: '3.5', photo: 'Assets/2.jpg', type: 'Boys',address: 'chak shahzad',rent: '12000'),
//     popular(name: 'Noor Bloack', rating: '4.9', photo: 'Assets/3.jpg', type: 'boys',address: 'Royal Avenue',rent: '13000'),
//     popular(name: 'Shahzad block', rating: '4.2', photo: 'Assets/4.jpg', type: 'boys',address: 'islamabad',rent: '14000'),
//     popular(name: 'Hello', rating: '4.0', photo: 'Assets/5.jpg', type: 'M',address: 'Park road ',rent: '12000'),
//     Recommended(address: '', name: 'Abasyn Boys Hostel', photo: 'Assets/6.jpg', rating: '', type: '',rent: '18000'),
//     Recommended(address: 'address', name: 'Hello G', photo: 'Assets/7.jpg', rating: '', type: '',rent: '16000'),
//     Recommended(address: 'address', name: 'kese ho hostel', photo: 'Assets/8.jpg', rating: '', type: '',rent: '12000'),
//     Recommended(address: '', name: 'Naam ni hai hamara', photo: 'Assets/9.jpg', rating: '', type: '',rent: '1000'),
//     Recommended(address: '', name: 'Picture hi kaafi hai', photo: 'Assets/splash screen.jpg', rating: '', type: '',rent: '12000')
//   ];
// }

// fetching data from database

  Future<List<hostels>> fetchHostels() async {
    print("hello");
    final response = await http.get(
        Uri.parse('http://192.168.18.141:3000/hostels/getData'));
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        print('100');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) =>
          hostels(
              name: json['hostel_name'],
              address: json['hostel_address'],
              photo: json['hostel_image'])).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
