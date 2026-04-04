import 'package:partsrunner/features/bottom_nav/data/models/bottom_nav_model.dart';

abstract class BottomNavRepository {
  Future<BottomNavModel> getUser();
}