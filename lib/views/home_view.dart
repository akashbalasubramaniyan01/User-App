import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/views/user_litview.dart';

import '../controllers/user_controllers.dart';


class HomeView extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              userController.locationData.value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )),
          Expanded(child: UserListView()),
        ],
      ),
    );
  }
}
