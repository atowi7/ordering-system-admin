import 'package:intl/intl.dart';

class OrderModel {
  final int id;
  String? status;
  final String paymentMethod;
  final String paymentStatus;
  final Map<String, dynamic>? branch;
  final String? notes;
  final List<dynamic> items;
  final Map<String, dynamic>? deliveryAddress;
  final Map<String, dynamic>? promoCode;
  final Map<String, dynamic>? prices;
  final String invoiceLink;
  final dynamic feedback;
  final String serviceType;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.branch,
    this.notes,
    required this.items,
    required this.deliveryAddress,
    required this.promoCode,
    required this.prices,
    required this.invoiceLink,
    this.feedback,
    required this.serviceType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      status: json['status'] as String,
      paymentMethod: json['payment_method'] as String,
      paymentStatus: json['payment_status'] as String,
      branch: json['branch'] != null
          ? json['branch'] as Map<String, dynamic>
          : null,
      notes: json['notes'] as String?,
      items: json['items'] as List<dynamic>,
      deliveryAddress: json['delivery_address'] != null
          ? json['delivery_address'] as Map<String, dynamic>
          : null,
      promoCode: json['promo_code'] != null
          ? json['promo_code'] as Map<String, dynamic>
          : null,
      prices: json['prices'] != null
          ? json['prices'] as Map<String, dynamic>
          : null,
      invoiceLink: json['invoice_link'] as String,
      feedback: json['feedback'],
      serviceType: json['service_type'] as String,
      createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['created_at']),
      updatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['updated_at']),
    );
  }
}
