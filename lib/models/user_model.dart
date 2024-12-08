class UserModel {
  final int id;
  final String name;
  final String email;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int shopId;
  final int shopSuperAdmin;
  final List<int>? branchIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.shopId,
    required this.shopSuperAdmin,
    this.branchIds,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      status: json['status'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      shopId: json['shop_id'] as int,
      shopSuperAdmin: json['shop_super_admin'] as int,
      branchIds: json['branch_ids'] != null
          ? (json['branch_ids'] as List).cast<int>()
          : null,
    );
  }
}
