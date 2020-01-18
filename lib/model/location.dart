class LocationClass {
  const LocationClass({this.location_id, this.location_name, this.location_description, this.location_image, this.location_longitude, this.location_latitude, this.location_phone_number, this.location_email, this.location_start_hours, this.location_end_hours});

  final int location_id;
  final String location_name;
  final String location_description;
  final String location_image;
  final double location_longitude;
  final double location_latitude;
  final String location_phone_number;
  final String location_email;
  final String location_start_hours;
  final String location_end_hours;

  factory LocationClass.fromJson(Map<String, dynamic> json) {
    return LocationClass(
      location_id: json['location_id'],
      location_name: json['location_name'],
      location_description: json['location_description'],
      location_image: json['location_image'],
      location_longitude: json['location_longitude'],
      location_latitude: json['location_latitude'],
      location_phone_number: json['location_phone_number'],
      location_email: json['location_email'],
      location_start_hours: json['location_start_hours'],
      location_end_hours: json['location_end_hours'],

    );
  }

  Map<String, dynamic> toMap() => {
    "location_id": location_id,
    "location_name": location_name,
    "location_description": location_description,
    "location_image": location_image,
    "location_longitude": location_longitude,
    "location_latitude": location_latitude,
    "location_phone_number": location_phone_number,
    "location_email": location_email,
    "location_start_hours": location_start_hours,
    "location_end_hours": location_end_hours,
  };
}