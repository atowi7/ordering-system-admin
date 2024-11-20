class OrderModel {
  final String id;
  final String username;
  final String phoneNumber;
  final String branch;
  final String paymentMethod;
  final String service;
  final String price;
  final String vat;
  final String mealname;
  final String mealnum;
  final String mealImage;
  String? status;
  final String date;
  OrderModel({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.branch,
    required this.paymentMethod,
    required this.service,
    required this.price,
    required this.vat,
    required this.mealname,
    required this.mealnum,
    required this.mealImage,
    required this.status,
    required this.date,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
      'branch': branch,
      'paymentMethod': paymentMethod,
      'service': service,
      'price': price,
      'vat': vat,
      'mealname': mealname,
      'mealnum': mealnum,
      'mealimage': mealImage,
      'status': status,
      'date': date,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phonenumber'],
      branch: json['branch'],
      paymentMethod: json['paymentmethod'],
      service: json['service'],
      price: json['price'],
      vat: json['vat'],
      mealname: json['mealname'],
      mealnum: json['mealnum'],
      mealImage: json['mealimage'],
      status: json['status'],
      date: json['date'],
    );
  }
}
