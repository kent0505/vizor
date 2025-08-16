class Restaurant {
  Restaurant({
    required this.id,
    required this.title,
    required this.phone,
    required this.address,
    required this.latlon,
    required this.hours,
    required this.city,
    this.position,
    this.status,
    this.photo,
  });

  final int id;
  final String title;
  final String phone;
  final String address;
  final String latlon;
  final String hours;
  final int city;
  final int? position;
  final int? status;
  final String? photo;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      title: json['title'],
      phone: json['phone'],
      address: json['address'],
      latlon: json['latlon'],
      hours: json['hours'],
      position: json['position'],
      city: json['city'],
      status: json['status'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'phone': phone,
      'address': address,
      'latlon': latlon,
      'hours': hours,
      'position': position,
      'city': city,
      'status': status,
      'photo': photo,
    };
  }
}
