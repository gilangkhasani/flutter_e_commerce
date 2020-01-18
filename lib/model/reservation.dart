class ReservationClass {
  const ReservationClass({this.reservation_id, this.reservation_name, this.reservation_phone_number, this.reservation_subject, this.reservation_messages, this.reservation_start_date_time, this.reservation_end_date_time});

  final int reservation_id;
  final String reservation_name;
  final String reservation_phone_number;
  final String reservation_subject;
  final String reservation_messages;
  final String reservation_start_date_time;
  final String reservation_end_date_time;


  factory ReservationClass.fromJson(Map<String, dynamic> json) {
    return ReservationClass(
      reservation_id: json['reservation_id'],
      reservation_name: json['reservation_name'],
      reservation_phone_number: json['reservation_phone_number'],
      reservation_subject: json['reservation_subject'],
      reservation_messages: json['reservation_messages'],
      reservation_start_date_time: json['reservation_start_date_time'],
      reservation_end_date_time: json['reservation_end_date_time'],
    );
  }

  Map<String, dynamic> toMap() => {
    "reservation_id": reservation_id,
    "reservation_name": reservation_name,
    "reservation_phone_number": reservation_phone_number,
    "reservation_subject": reservation_subject,
    "reservation_messages": reservation_messages,
    "reservation_start_date_time": reservation_start_date_time,
    "reservation_end_date_time": reservation_end_date_time,
  };
}