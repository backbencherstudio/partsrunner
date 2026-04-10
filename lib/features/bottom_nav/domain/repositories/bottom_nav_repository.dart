import 'package:partsrunner/features/bottom_nav/data/models/user_model.dart';

abstract class BottomNavRepository {
  Future<UserModel> getUser();
}