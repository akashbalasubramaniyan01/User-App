import 'package:get/get.dart';
import '../api_services/api_service.dart';
import '../models/user_model.dart';
import 'package:hive/hive.dart';

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var locationData = ''.obs;

  // Store user images
  var userImages = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
    fetchUsers();
    loadStoredImages();
  }

  Future<void> fetchUsers() async {
    try {
      users.value = await ApiService.fetchUsers();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getLocation() async {
    loc.Location location = loc.Location();

    // Request location permission
    loc.PermissionStatus permission = await location.requestPermission();
    if (permission == loc.PermissionStatus.granted) {
      loc.LocationData data = await location.getLocation();
      String address = 'Unknown address';

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(data.latitude!, data.longitude!);
        Placemark place = placemarks.first;
        address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } catch (e) {
        address = "Failed to fetch address: $e";
      }

      locationData.value = 'Lat: ${data.latitude}, Long: ${data.longitude}\nAddress: $address';
    } else {
      locationData.value = 'Location permission denied';
    }
  }

  void uploadImage(int userId, String imagePath) async {
    final box = Hive.box('uploaded_images');
    box.put(userId, imagePath);
    userImages[userId] = imagePath; // Update the observable map
    fetchUsers();
    loadStoredImages();
  }

  String? getImagePath(int userId) {
    return userImages[userId];
  }

  void loadStoredImages() {
    final box = Hive.box('uploaded_images');
    for (var key in box.keys) {
      userImages[key as int] = box.get(key);
    }
  }
}

