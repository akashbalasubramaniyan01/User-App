import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_controllers.dart';


class UserListView extends StatelessWidget {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: userController.users.length,
        itemBuilder: (context, index) {
          final user = userController.users[index];
          final uploadedImage = userController.getImagePath(user.id);

          return ListTile(
            leading: uploadedImage != null
                ? Image.file(File(uploadedImage))
                : Image.network(user.avatar),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: Icon(Icons.upload),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  userController.uploadImage(user.id, pickedImage.path);
                }
              },
            ),
          );
        },
      );
    });
  }
}
