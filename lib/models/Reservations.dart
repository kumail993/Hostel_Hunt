class Reservation {
  final int reservationId;
  final String reservationName;
  final String reservationEmail;
  final String reservationPhone;
  final String reservationMsg;
  //final String reservationType;
  //final String hostelName;

  Reservation({
    required this.reservationId,
    required this.reservationName,
    required this.reservationEmail,
    required this.reservationPhone,
    required this.reservationMsg
    //required this.reservationType,
    //required this.hostelName,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['listing_id'],
      reservationName: json['name'],
      reservationEmail: json['email'],
      reservationPhone: json['phone'],
      reservationMsg: json['message'],
      //reservationType: json['type'.toString()],
      //hostelName: json['hostel_name'],
    );
  }
}