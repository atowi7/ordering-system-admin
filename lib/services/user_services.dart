import 'package:ordering_system_admin/models/user_model.dart';

class UserServices {
  Future<UserModel> login(String name, String password) async {
    return UserModel(id: 'id', name: 'name', email: 'email');
  }
}
