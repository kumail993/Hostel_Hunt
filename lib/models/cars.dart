class hostels {
  final String name;
  final String rating;
  final String photo;
  final String type;
  final String address;
  final String rent;
  hostels({
    required this.name,
    required this.rating,
    required this.photo,
    required this.type,
    required this.address,
    required this.rent
  }

  );
  int compareTo(hostels other) => rent.compareTo(other.rent);
}
class popular extends hostels{
  popular({required super.address,required super.name,required super.photo,required super.rating,required super.type,required super.rent});

}
class Recommended extends hostels{
  Recommended({required super.address,required super.name,required super.photo,required super.rating,required super.type,required super.rent});
}
// class Nearest extends hostels{
//   Nearest({required super.name, required super.rating, required super.photo, required super.type, required super.address,required super.rent});
//
// }
// class Paid extends hostels{
//   Paid({required super.name, required super.rating, required super.photo, required super.type, required super.address,required super.rent});
// }
class All extends hostels{
  All({required super.name, required super.rating, required super.photo, required super.type, required super.address, required super.rent});

}