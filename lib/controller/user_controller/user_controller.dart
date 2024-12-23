import 'package:hire4consult_employ/model/user_model/user_model.dart';

abstract class UserController {
  Future<UserModel?> getUserDetails(String userId);
}
