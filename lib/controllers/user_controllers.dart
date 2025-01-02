import 'package:get/get.dart';
import '../api_services/api_service.dart';
import '../models/user_model.dart';

import 'package:location/location.dart';
import 'package:hive/hive.dart';

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var locationData = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    getLocation();
  }

  Future<void> fetchUsers() async {
    try {
      users.value = await ApiService.fetchUsers();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getLocation() async {
    Location location = Location();
    PermissionStatus permission = await location.requestPermission();
    if (permission == PermissionStatus.granted) {
      LocationData data = await location.getLocation();
      locationData.value = 'Lat: ${data.latitude}, Long: ${data.longitude}';
    }
  }

  void uploadImage(int userId, String imagePath) async {
    final box = Hive.box('uploaded_images');
    box.put(userId, imagePath);
  }

  String? getImagePath(int userId) {
    final box = Hive.box('uploaded_images');
    return box.get(userId);
  }
}
