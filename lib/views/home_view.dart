import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/views/user_litview.dart';

import '../controllers/user_controllers.dart';


class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        elevation: 3.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userController.locationData.value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          SizedBox(height: 20,),
          Expanded(child: UserListView()),
        ],
      ),
    );
  }
}
